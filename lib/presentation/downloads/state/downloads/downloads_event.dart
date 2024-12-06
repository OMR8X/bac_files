part of 'downloads_bloc.dart';

final class DownloadsEvent extends Equatable {
  const DownloadsEvent();

  @override
  List<Object> get props => [];
}

final class AddDownloadOperationEvent extends DownloadsEvent {
  const AddDownloadOperationEvent({required this.file});
  final BacFile file;
  @override
  List<Object> get props => [file];
}

final class AddSharedOperationEvent extends DownloadsEvent {
  const AddSharedOperationEvent({required this.paths});
  final List<String> paths;
  @override
  List<Object> get props => [paths];
}

final class InitializeDownloadsEvent extends DownloadsEvent {
  const InitializeDownloadsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateOperationsEvent extends DownloadsEvent {
  const UpdateOperationsEvent({this.operations});
  final List<Operation>? operations;
  @override
  List<Object> get props => [];
}

final class StartOperationEvent extends DownloadsEvent {
  const StartOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [];
}

final class StartAllOperationsEvent extends DownloadsEvent {
  const StartAllOperationsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteAllOperationsEvent extends DownloadsEvent {
  const DeleteAllOperationsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteOperationEvent extends DownloadsEvent {
  const DeleteOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class StopOperationEvent extends DownloadsEvent {
  const StopOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class StopAllOperationEvent extends DownloadsEvent {
  const StopAllOperationEvent();
  @override
  List<Object> get props => [];
}

final class RefreshOperationEvent extends DownloadsEvent {
  const RefreshOperationEvent();
  @override
  List<Object> get props => [];
}

final class CancelOperationEvent extends DownloadsEvent {
  const CancelOperationEvent({required this.operation});
  final Operation operation;
  @override
  List<Object> get props => [operation];
}

final class CompleteOperationEvent extends DownloadsEvent {
  const CompleteOperationEvent();
}

final class FailedOperationEvent extends DownloadsEvent {
  const FailedOperationEvent();
}
