import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../../../core/services/debug/debugging_client.dart';
import '../../../../core/services/debug/debugging_manager.dart';
import '../../../files/data/responses/download_file_response.dart';
import '../../../files/domain/requests/download_file_request.dart';
import '../../../files/domain/usecases/download_file_usecase.dart';
import '../../../operations/domain/entities/operation.dart';
import '../../../operations/domain/entities/operation_state.dart';
import '../../../operations/domain/usecases/get_operation_usecase.dart';
import '../../../operations/domain/usecases/get_operations_usecase.dart';
import '../../../operations/domain/usecases/update_operation_usecase.dart';
import '../../../operations/domain/usecases/update_operations_usecase.dart';
import '../../domain/repositories/background_downloads_messenger_repository.dart';

abstract class BackgroundDownloadsDataSource {
  Future<Either<Failure, DownloadFileResponse>> startDownload({required DownloadFileRequest request});
}

class BackgroundDownloadsDataSourceImplements implements BackgroundDownloadsDataSource {
  //
  final BackgroundMessengerRepository _backgroundMessengerRepository;
  //
  final DownloadFileUsecase _downloadFileUsecase;
  //
  final UpdateOperationUseCase _updateOperationUseCase;

  BackgroundDownloadsDataSourceImplements({
    required CacheManager cacheManager,
    required BackgroundMessengerRepository backgroundMessengerRepository,
    required DownloadFileUsecase uploadFileUsecase,
    required UpdateOperationUseCase updateOperationUseCase,
  })  : _backgroundMessengerRepository = backgroundMessengerRepository,
        _downloadFileUsecase = uploadFileUsecase,
        _updateOperationUseCase = updateOperationUseCase;

  @override
  Future<Either<Failure, DownloadFileResponse>> startDownload({required DownloadFileRequest request}) async {
    //
    final requestCompleter = Completer<Either<Failure, DownloadFileResponse>>();
    //
    request = request.copyWith(
      onSendProgress: (sent, total) {
        _onRequestProgressing(
          operation: request.operation,
          sent: sent,
          total: total,
        );
      },
    );
    //
    await _downloadFileUsecase(request: request).then((response) {
      response.fold(
        (l) async {
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
  }

  Future<void> _onRequestProgressing({required Operation operation, required int sent, required int total}) async {
    //
    _backgroundMessengerRepository.sendProgressMessageMessage(
      fileId: operation.file.id,
      operationId: operation.id,
      operationType: operation.type,
      title: operation.file.title,
      sent: sent,
      total: total,
    );

    //
    return;
  }

  Future<void> _onRequestCompleted({required DownloadFileRequest request}) async {
    //
    await sl<CacheManager>().refresh();
    //
    await _updateOperationUseCase(operation: request.operation.copyWith(state: OperationState.succeed));
    //
    await _backgroundMessengerRepository.sendOperationCompletedMessage(
      operationId: request.operation.id,
      operationType: request.operation.type,
      fileId: request.operation.file.id,
      title: request.operation.file.title,
    );

    //
    return;
  }

  Future<void> _onRequestFailed({required DownloadFileRequest request, required Failure failure}) async {
    //
    await sl<CacheManager>().refresh();
    //
    String? error = failure is CanceledFailure ? null : failure.message;
    OperationState? state = failure is CanceledFailure ? OperationState.initializing : OperationState.failed;
    //
    await _updateOperationUseCase(operation: request.operation.copyWith(state: state, error: error));
    //
    await _backgroundMessengerRepository.sendOperationFailed(
      operationId: request.operation.id,
      operationType: request.operation.type,
      fileId: request.operation.file.id,
      title: request.operation.file.title,
    );
    //
    return;
  }
}
