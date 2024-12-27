import 'dart:async';
import 'package:bac_files/core/injector/app_injection.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../../../core/services/debug/debugging_manager.dart';
import '../../../downloads/domain/repositories/background_downloads_messenger_repository.dart';
import '../../../files/data/responses/upload_file_response.dart';
import '../../../files/domain/requests/upload_file_request.dart';
import '../../../files/domain/usecases/upload_file_usecase.dart';
import '../../../operations/domain/entities/operation.dart';
import '../../../operations/domain/entities/operation_state.dart';
import '../../../operations/domain/usecases/update_operation_usecase.dart';

abstract class BackgroundUploadsDataSource {
  Future<Either<Failure, UploadFileResponse>> startUpload({required UploadFileRequest request});
}

class BackgroundUploadsDataSourceImplements implements BackgroundUploadsDataSource {
  //
  final BackgroundMessengerRepository _backgroundMessengerRepository;
  //
  final UploadFileUsecase _uploadFileUsecase;
  //
  final UpdateOperationUseCase _updateOperationUseCase;
  //
  BackgroundUploadsDataSourceImplements({
    required BackgroundMessengerRepository backgroundMessengerRepository,
    required UploadFileUsecase uploadFileUsecase,
    required UpdateOperationUseCase updateOperationUseCase,
  })  : _backgroundMessengerRepository = backgroundMessengerRepository,
        _uploadFileUsecase = uploadFileUsecase,
        _updateOperationUseCase = updateOperationUseCase;

  @override
  Future<Either<Failure, UploadFileResponse>> startUpload({required UploadFileRequest request}) async {
    //
    final requestCompleter = Completer<Either<Failure, UploadFileResponse>>();
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

    //
    await _uploadFileUsecase(request: request).then((response) {
      response.fold(
        (l) async {
          await _onRequestFailed(request: request, failure: l);
          requestCompleter.complete(left(l));
        },
        (r) async {
          await _onRequestCompleted(request: request);
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
      operationType: operation.type,
      operationId: operation.id,
      title: operation.file.title,
      sent: sent,
      total: total,
    );
    //
    return;
  }

  Future<void> _onRequestCompleted({required UploadFileRequest request}) async {
    //
    await sl<CacheManager>().refresh();
    //

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

  Future<void> _onRequestFailed({required UploadFileRequest request, required Failure failure}) async {
    //
    await sl<CacheManager>().refresh();
    //
    String? error = failure is CanceledFailure ? null : failure.message;
    OperationState? state = failure is CanceledFailure ? OperationState.initializing : OperationState.failed;
    //

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
