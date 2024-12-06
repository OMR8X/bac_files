part of 'uploads_bloc.dart';

enum UploadsStatus { initializing, content, failure }

final class UploadsState extends Equatable {
  final List<Operation> operations;
  final UploadsStatus status;
  final Failure? failure;
  const UploadsState({
    required this.operations,
    required this.status,
    this.failure,
  });
  @override
  List<Object?> get props {
    return [operations, operations.length, status, failure];
  }

  UploadsState addOperation(Operation operation) {
    int lastId = operations.isEmpty ? 0 : operations.last.id;
    return copyWith(operations: List.from(operations)..add(operation.copyWith(id: lastId + 1)));
  }

  UploadsState removeOperation(int id) {
    return copyWith(operations: List.from(operations)..removeWhere((operation) => operation.id == id));
  }

  factory UploadsState.initializing() {
    return UploadsState(
      operations: List.empty(growable: true),
      status: UploadsStatus.initializing,
      failure: null,
    );
  }
  factory UploadsState.content({required List<Operation> operations}) {
    return UploadsState(
      operations: operations,
      status: UploadsStatus.content,
      failure: null,
    );
  }
  factory UploadsState.failure({required Failure failure}) {
    return UploadsState(
      operations: const [],
      status: UploadsStatus.failure,
      failure: failure,
    );
  }

  UploadsState copyWith({
    List<Operation>? operations,
    UploadsStatus? status,
    Failure? failure,
  }) {
    return UploadsState(
      operations: operations ?? this.operations,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
