part of 'uploads_bloc.dart';

final class UploadsEvent extends Equatable {
  const UploadsEvent();

  @override
  List<Object> get props => [];
}

final class AddOperationEvent extends UploadsEvent {
  const AddOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class AddSharedOperationEvent extends UploadsEvent {
  const AddSharedOperationEvent({required this.paths});
  final List<String> paths;
  @override
  List<Object> get props => [paths];
}

final class InitializeUploadsEvent extends UploadsEvent {
  const InitializeUploadsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateOperationsEvent extends UploadsEvent {
  const UpdateOperationsEvent({this.operations});
  final List<Operation>? operations;
  @override
  List<Object> get props => [];
}

final class StartOperationEvent extends UploadsEvent {
  const StartOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [];
}

final class StartAllOperationsEvent extends UploadsEvent {
  const StartAllOperationsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteAllOperationsEvent extends UploadsEvent {
  const DeleteAllOperationsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteOperationEvent extends UploadsEvent {
  const DeleteOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class StopOperationEvent extends UploadsEvent {
  const StopOperationEvent({required this.operation});
  final Operation operation;
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
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class CompleteOperationEvent extends UploadsEvent {
  const CompleteOperationEvent();
}

final class FailedOperationEvent extends UploadsEvent {
  const FailedOperationEvent();
}
