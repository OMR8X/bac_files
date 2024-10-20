part of 'update_operation_file_bloc.dart';

final class UpdateOperationFileEvent extends Equatable {
  const UpdateOperationFileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateOperationFileInitializeEvent extends UpdateOperationFileEvent {
  final int operationId;
  const UpdateOperationFileInitializeEvent({
    required this.operationId,
  });

  @override
  List<Object> get props => [operationId];
}

final class UpdateOperationFileEditEvent extends UpdateOperationFileEvent {
  final BacFile bacFile;
  const UpdateOperationFileEditEvent({
    required this.bacFile,
  });
  @override
  List<Object> get props => [bacFile];
}

final class UpdateOperationFileSaveEvent extends UpdateOperationFileEvent {
  const UpdateOperationFileSaveEvent();
}
