part of 'update_file_bloc.dart';

enum UpdateFileStatus { loading, fetching, initial, success, failure }

final class UpdateFileState extends Equatable {
  //
  final BacFile bacFile;
  final UpdateFileStatus status;
  final Failure? failure;
  //
  const UpdateFileState({
    required this.bacFile,
    required this.status,
    required this.failure,
  });
  //
  factory UpdateFileState.initial() {
    return UpdateFileState(
      bacFile: BacFile.empty(),
      status: UpdateFileStatus.initial,
      failure: null,
    );
  }
  UpdateFileState copyWith({
    BacFile? bacFile,
    UpdateFileStatus? status,
    Failure? failure,
  }) {
    return UpdateFileState(
      bacFile: bacFile ?? this.bacFile,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [bacFile, status, failure];
}
