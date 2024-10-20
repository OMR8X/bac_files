part of 'uploads_bloc.dart';

final class UploadsEvent extends Equatable {
  const UploadsEvent();

  @override
  List<Object> get props => [];
}

final class AddOperationEvent extends UploadsEvent {
  const AddOperationEvent({required this.operation});
  final UploadOperation operation;
  @override
  List<Object> get props => [operation];
}

final class AddSharedOperationEvent extends UploadsEvent {
  const AddSharedOperationEvent({required this.path});
  final String path;
  @override
  List<Object> get props => [path];
}

final class InitializeOperationsEvent extends UploadsEvent {
  const InitializeOperationsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateOperationsEvent extends UploadsEvent {
  const UpdateOperationsEvent();

  @override
  List<Object> get props => [];
}

final class StartOperationEvent extends UploadsEvent {
  const StartOperationEvent({required this.operation});
  final UploadOperation operation;
  @override
  List<Object> get props => [];
}

final class StartAllOperationsEvent extends UploadsEvent {
  const StartAllOperationsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteOperationEvent extends UploadsEvent {
  const DeleteOperationEvent({required this.operation});
  final UploadOperation operation;
  @override
  List<Object> get props => [operation];
}

final class StopOperationEvent extends UploadsEvent {
  const StopOperationEvent({required this.operation});
  final UploadOperation operation;
  @override
  List<Object> get props => [operation];
}

final class StopAllOperationEvent extends UploadsEvent {
  const StopAllOperationEvent();
  @override
  List<Object> get props => [];
}

final class RefreshOperationEvent extends UploadsEvent {
  const RefreshOperationEvent();
  @override
  List<Object> get props => [];
}

final class CancelOperationEvent extends UploadsEvent {
  const CancelOperationEvent({required this.operation});
  final UploadOperation operation;
  @override
  List<Object> get props => [operation];
}

final class CompleteOperationEvent extends UploadsEvent {
  const CompleteOperationEvent({required this.operation});
  final int operation;
  @override
  List<Object> get props => [];
}

final class FailedOperationEvent extends UploadsEvent {
  const FailedOperationEvent({required this.operation});
  final int operation;
  @override
  List<Object> get props => [];
}
