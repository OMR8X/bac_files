import 'dart:async';

import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:bac_files_admin/features/uploads/domain/repositories/background_messenger_repository.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operations_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../../files/data/responses/upload_file_response.dart';
import '../../../files/domain/requests/upload_file_request.dart';
import '../../../files/domain/usecases/upload_file_usecase.dart';
import '../../domain/entities/operation_state.dart';
import '../../domain/usecases/operations/get_operation_usecase.dart';
import '../../domain/usecases/operations/get_operations_usecase.dart';
import '../../domain/usecases/operations/update_operation_usecase.dart';

abstract class BackgroundUploadsDataSource {
  //
  //
  Future<List<UploadFileRequest>> getPendingUploads();
  //
  Future<void> startAllUploads();
  Future<void> startUpload({required int operationID});
  //
  Future<void> stopAllUploads();
  Future<void> stopUpload({required int operationID});
  //
  Future<Either<Failure, UploadFileResponse>> startRequest({required UploadFileRequest request});
}

class BackgroundUploadsDataSourceImplements implements BackgroundUploadsDataSource {
  //
  final CacheManager _cacheManager;
  //
  final BackgroundMessengerRepository _backgroundMessengerRepository;
  //
  final GetOperationUseCase _getOperationUseCase;
  //
  final GetAllOperationsUseCase _getOperationsUseCase;
  //
  final UploadFileUsecase _uploadFileUsecase;
  //
  final UpdateOperationUseCase _updateOperationUseCase;
  //
  final UpdateAllOperationsStateUseCase _updateAllOperationsStateUseCase;

  BackgroundUploadsDataSourceImplements({
    required CacheManager cacheManager,
    required BackgroundMessengerRepository backgroundMessengerRepository,
    required GetOperationUseCase getOperationUseCase,
    required GetAllOperationsUseCase getOperationsUseCase,
    required UploadFileUsecase uploadFileUsecase,
    required UpdateOperationUseCase updateOperationUseCase,
    required UpdateAllOperationsStateUseCase updateAllOperationsStateUseCase,
  })  : _cacheManager = cacheManager,
        _backgroundMessengerRepository = backgroundMessengerRepository,
        _getOperationUseCase = getOperationUseCase,
        _getOperationsUseCase = getOperationsUseCase,
        _uploadFileUsecase = uploadFileUsecase,
        _updateOperationUseCase = updateOperationUseCase,
        _updateAllOperationsStateUseCase = updateAllOperationsStateUseCase;

  @override
  Future<List<UploadFileRequest>> getPendingUploads() async {
    //
    List<UploadFileRequest> requests = await _getOperationsUseCase.call().then((response) {
      return response.fold((l) => [], (r) => r.map((operation) => UploadFileRequest.fromOperation(operation)).toList());
    });
    //
    debugPrint("requests before: ${requests.length}");
    //
    requests.removeWhere((e) => e.operation.state != OperationState.pending);
    //
    debugPrint("requests after: ${requests.length}");
    //
    return requests;
  }

  @override
  Future<void> startAllUploads() async {
    //
    debugPrint("STARTING ALL UPLOADS..");
    //
    await _updateAllOperationsStateUseCase.call(state: OperationState.pending).then((response) {
      response.fold(
        (l) {},
        (r) async {
          await _backgroundMessengerRepository.sendUpdateState(operations: r);
        },
      );
    });
    //
    return;
  }

  @override
  Future<void> startUpload({required int operationID}) async {
    //
    debugPrint("startingUpload in data source");
    //
    final Completer completer = Completer<void>();
    //
    // final UploadOperation operation=
    await _getOperationUseCase.call(operationId: operationID).then((response) {
      response.fold(
        (l) {
          debugPrint("error while getting operation: $l");
        },
        (r) async {
          debugPrint("updating the operation state");
          await _updateOperationUseCase.call(operation: r.copyWith(state: OperationState.pending)).then((response) {
            response.fold(
              (l) {},
              (r) async {
                await _backgroundMessengerRepository.sendUpdateState(operations: r);
              },
            );
          });

          completer.complete();
        },
      );
    });
    //
    await completer.future;
    //
    return;
  }

  @override
  Future<void> stopAllUploads() async {
    //
    debugPrint("5 - STOPPING ALL UPLOADS..");
    //
    await _updateAllOperationsStateUseCase.call(state: OperationState.initializing).then((response) {
      response.fold(
        (l) {},
        (r) async {
          await _backgroundMessengerRepository.sendUpdateState(operations: r);
        },
      );
    });

    //
    return;
  }

  @override
  Future<void> stopUpload({required int operationID}) async {
    //
    return;
  }

  @override
  Future<Either<Failure, UploadFileResponse>> startRequest({required UploadFileRequest request}) async {
    //
    debugPrint("STARTING REQUEST..");
    //
    await _updateOperationUseCase(
      operation: request.operation.copyWith(
        state: OperationState.uploading,
      ),
    );
    //
    final requestCompleter = Completer<Either<Failure, UploadFileResponse>>();
    //
    await _uploadFileUsecase.call(request: request.copyWith(
      onSendProgress: (sent, total) {
        _onRequestProgressing(sent: sent, total: total, operation: request.operation);
      },
    )).then((response) {
      response.fold(
        (l) async {
          //
          debugPrint("error while uploading file: $l");
          //
          await _onRequestFailed(request: request, failure: l);
          //
          requestCompleter.complete(left(l));
        },
        (r) async {
          //
          await _onRequestCompleted(request: request);
          //
          requestCompleter.complete(right(r));
        },
      );
    });

    //
    return await requestCompleter.future;

    ///
  }

  Future<void> _onRequestProgressing({required UploadOperation operation, required int sent, required int total}) async {
    //
    debugPrint("progress is ${sent / total}");
    //
    _backgroundMessengerRepository.sendProgressMessageMessage(
      id: operation.id,
      title: operation.file.title,
      sent: sent,
      total: total,
    );

    //
    return;
  }

  Future<void> _onRequestCompleted({required UploadFileRequest request}) async {
    //
    debugPrint("sending completed message..");
    //
    await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.succeed));
    //
    await _backgroundMessengerRepository.sendOperationCompletedMessage(
      id: request.operation.id,
      title: request.operation.file.title,
    );
    //
    await _backgroundMessengerRepository.sendUpdateState();
    //
    return;
  }

  Future<void> _onRequestFailed({required UploadFileRequest request, required Failure failure}) async {
    //
    await _updateOperationUseCase(
      operation: request.operation.copyWith(
        state: OperationState.failed,
        error: failure.message,
      ),
    );
    //
    await _backgroundMessengerRepository.sendOperationFailed(
      id: request.operation.id,
      title: request.operation.file.title,
    );
    //
    await _backgroundMessengerRepository.sendUpdateState();
    //
    return;
  }
}
