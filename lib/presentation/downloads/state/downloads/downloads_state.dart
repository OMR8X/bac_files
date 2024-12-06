part of 'downloads_bloc.dart';

enum DownloadStatus { initializing, content, failure }

final class DownloadsState extends Equatable {
  final List<Operation> operations;
  final DownloadStatus status;
  final Failure? failure;
  const DownloadsState({
    required this.operations,
    required this.status,
    this.failure,
  });
  @override
  List<Object?> get props {
    return [operations, operations.length, status, failure];
  }

  DownloadsState addOperation(Operation operation) {
    int lastId = operations.isEmpty ? 0 : operations.last.id;
    return copyWith(operations: List.from(operations)..add(operation.copyWith(id: lastId + 1)));
  }

  DownloadsState removeOperation(int id) {
    return copyWith(operations: List.from(operations)..removeWhere((operation) => operation.id == id));
  }

  factory DownloadsState.initializing() {
    return DownloadsState(
      operations: List.empty(growable: true),
      status: DownloadStatus.initializing,
      failure: null,
    );
  }
  factory DownloadsState.content({required List<Operation> operations}) {
    return DownloadsState(
      operations: operations,
      status: DownloadStatus.content,
      failure: null,
    );
  }
  factory DownloadsState.failure({required Failure failure}) {
    return DownloadsState(
      operations: const [],
      status: DownloadStatus.failure,
      failure: failure,
    );
  }

  DownloadsState copyWith({
    List<Operation>? operations,
    DownloadStatus? status,
    Failure? failure,
  }) {
    return DownloadsState(
      operations: operations ?? this.operations,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
