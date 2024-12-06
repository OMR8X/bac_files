part of 'update_operation_file_bloc.dart';

enum UpdateOperationFileStatus { loading, fetching, initial, success, failure }

final class UpdateOperationFileState extends Equatable {
  //
  final BacFile bacFile;
  final UpdateOperationFileStatus status;
  final Operation operation;
  final Failure? failure;
  //
  const UpdateOperationFileState({
    required this.bacFile,
    required this.operation,
    required this.status,
    required this.failure,
  });
  //
  factory UpdateOperationFileState.initial() {
    return UpdateOperationFileState(
      bacFile: BacFile.empty(),
      operation: Operation.empty(),
      status: UpdateOperationFileStatus.initial,
      failure: null,
    );
  }
  UpdateOperationFileState copyWith({
    BacFile? bacFile,
    Operation? operation,
    UpdateOperationFileStatus? status,
    Failure? failure,
  }) {
    return UpdateOperationFileState(
      bacFile: bacFile ?? this.bacFile,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [bacFile, status, failure, operation];
}
