part of 'create_file_bloc.dart';

final class CreateFileEvent extends Equatable {
  const CreateFileEvent();

  @override
  List<Object> get props => [];
}

final class CreateFileInitializeEvent extends CreateFileEvent {
  const CreateFileInitializeEvent();

  @override
  List<Object> get props => [];
}

final class CreateFilePickFileEvent extends CreateFileEvent {
  final String path;
  const CreateFilePickFileEvent({required this.path});
  @override
  List<Object> get props => [];
}


final class CreateFileSubmitEvent extends CreateFileEvent {
  final String path;
  final BacFile bacFile;
  const CreateFileSubmitEvent({
    required this.bacFile,
    required this.path,
  });

  @override
  List<Object> get props => [bacFile];
}
