part of 'create_file_bloc.dart';

enum CreateFileStatus { loading, initial, success, failure }

final class CreateFileState extends Equatable {
  //
  final BacFile bacFile;
  final CreateFileStatus status;
  final Failure? failure;
  //
  const CreateFileState({
    required this.bacFile,
    required this.status,
    required this.failure,
  });

  factory CreateFileState.initial() {
    return CreateFileState(
      bacFile: BacFile.empty(),
      status: CreateFileStatus.initial,
      failure: null,
    );
  }
  CreateFileState copyWith({
    BacFile? bacFile,
    CreateFileStatus? status,
    Failure? failure,
  }) {
    return CreateFileState(
      bacFile: bacFile ?? this.bacFile,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [bacFile, status, failure];
}
