part of 'update_file_bloc.dart';

sealed class UpdateFileEvent extends Equatable {
  const UpdateFileEvent();
  @override
  List<Object> get props => [];
}

final class UpdateFileInitializeEvent extends UpdateFileEvent {
  final String fileId;
  const UpdateFileInitializeEvent({required this.fileId});

  @override
  List<Object> get props => [fileId];
}

final class UpdateFileEditEvent extends UpdateFileEvent {
  final BacFile bacFile;
  const UpdateFileEditEvent({
    required this.bacFile,
  });

  @override
  List<Object> get props => [bacFile];
}

final class UpdateFileUploadEvent extends UpdateFileEvent {
  const UpdateFileUploadEvent();
  @override
  List<Object> get props => [];
}
