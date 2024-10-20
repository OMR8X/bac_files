import 'dart:async';

import 'package:bac_files_admin/core/services/background_service/managers/background_messages_manger.dart';
import 'package:bac_files_admin/core/services/notifications/app_notification_service.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../features/files/domain/requests/upload_file_request.dart';
import '../../../../features/files/domain/usecases/upload_file_usecase.dart';
import '../../../injector/app_injection.dart';
import '../../cache/cache_manager.dart';

abstract class BackgroundUploadsManager {
  //
  void initialize(ServiceInstance backgroundService);

  ///
  void startQueue();

  ///
  Future<void> startRequest({required UploadFileRequest request});

  ///
  Future<void> refreshOperations();

  ///
  void cancelOperation({required int operationId});

  ///
  Future<void> onRequestCompleted({required UploadFileRequest request});

  ///
  Future<void> onRequestFailed({required UploadFileRequest request, required String message});

  ///
  void onProgress({required String fileId, required int sent, required int total});
}

class BackgroundUploadsManagerImplements implements BackgroundUploadsManager {
  ///
  bool _isQueueRunning = false;

  ///
  final List<UploadFileRequest> _requestsQueue;

  ///
  late final ServiceInstance _backgroundService;
  ////
  late final BackgroundMessagesManger _backgroundMessagesManger;

  ///
  final UpdateOperationUseCase _updateOperationUseCase;
  final GetAllOperationsUseCase _getOperationsUseCase;

  BackgroundUploadsManagerImplements({
    required UpdateOperationUseCase updateOperationUseCase,
    required GetAllOperationsUseCase getOperationsUseCase,
  })  : _requestsQueue = List.empty(growable: true),
        _updateOperationUseCase = updateOperationUseCase,
        _getOperationsUseCase = getOperationsUseCase;

  @override
  void initialize(ServiceInstance backgroundService) {
    //
    _backgroundService = backgroundService;
    //
    _backgroundMessagesManger = BackgroundMessagesMangerImplements(
      backgroundService: backgroundService,
    );
  }

  ///
  @override
  void cancelOperation({required int operationId}) async {
    //
    final request = _requestsQueue.where((req) => req.operation.id == operationId).firstOrNull;
    //
    if (request != null) {
      //
      request.cancelToken.cancel();
      //
      _requestsQueue.remove(request);
      //
      await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.canceled));
    }
  }

  ///
  @override
  void onProgress({required String fileId, required int sent, required int total}) async {
    _backgroundService.invoke("on-progress", {
      "file_id": fileId,
      "sent": sent,
      "total": total,
    });
    return;
  }

  ///
  @override
  void startQueue() async {
    ///
    if (_isQueueRunning) return;

    ///
    _isQueueRunning = true;

    ///
    while (_requestsQueue.isNotEmpty) {
      //
      final request = _requestsQueue.removeAt(0);
      //
      try {
        await startRequest(request: request);
      } catch (e) {
        continue;
      }
    }
    //
    _isQueueRunning = false;
    //
    return;
  }

  ///
  @override
  Future<void> refreshOperations() async {
    //
    await sl<CacheManager>().init();
    //
    await _getOperationsUseCase().then((response) {
      response.fold(
        (l) {},
        (r) async {
          //
          _requestsQueue.removeWhere((e) => true);
          //
          for (var operation in r) {
            if (operation.state == OperationState.pending) {
              _requestsQueue.add(
                UploadFileRequest(
                  operation: operation,
                  cancelToken: CancelToken(),
                  onSendProgress: (int sent, int total) {
                    onProgress(fileId: operation.file.id, sent: sent, total: total);
                  },
                ),
              );
            }
          }
          //
          startQueue();
        },
      );
    });
    return;
  }

  ///
  @override
  Future<void> startRequest({required UploadFileRequest request}) async {
    ///
    await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.uploading));

    ///
    final requestCompleter = Completer<void>();

    ///
    await sl<UploadFileUsecase>().call(request: request).then((response) {
      response.fold(
        (l) async {
          sl<AppNotificationsService>().showMessageNotification(
            id: request.operation.id,
            title: "failed",
            message: l.message,
          );
          await onRequestFailed(request: request, message: l.message);
          requestCompleter.complete();
        },
        (r) async {
          sl<AppNotificationsService>().showMessageNotification(
            id: request.operation.id,
            title: "success",
            message: r.toString(),
          );
          await onRequestCompleted(request: request);
          requestCompleter.complete();
        },
      );
    });

    ///
    return requestCompleter.future;
  }

  @override
  Future<void> onRequestCompleted({required UploadFileRequest request}) async {
    //
    await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.succeed));
    //
    await _backgroundMessagesManger.sendOperationCompletedMessage(
      fileId: request.operation.file.id,
    );
  }

  @override
  Future<void> onRequestFailed({required UploadFileRequest request, required String message}) async {
    //
    await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.failed));
    //
    _backgroundMessagesManger.sendOperationFailedMessage(
      fileId: request.operation.file.id,
      message: message,
    );
  }
}
