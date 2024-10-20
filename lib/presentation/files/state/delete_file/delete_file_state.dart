part of 'delete_file_bloc.dart';

enum DeleteFileStatus { loading, initial, success, failure }

final class DeleteFileState extends Equatable {
  final DeleteFileStatus status;
  final Failure? failure;

  const DeleteFileState({required this.status, required this.failure});

  factory DeleteFileState.initial() {
    return const DeleteFileState(
      status: DeleteFileStatus.initial,
      failure: null,
    );
  }
  DeleteFileState copyWith({
    DeleteFileStatus? status,
    Failure? failure,
  }) {
    return DeleteFileState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [];
}
