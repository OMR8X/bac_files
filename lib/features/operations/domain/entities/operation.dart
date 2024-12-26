import 'package:equatable/equatable.dart';

import '../../../files/domain/entities/bac_file.dart';
import 'operation_state.dart';
import 'operation_type.dart';

class Operation extends Equatable {
  ///
  final int id;

  ///
  final String path;

  ///
  final BacFile file;

  ///
  final OperationState state;

  ///
  final OperationType type;

  ///
  final String? error;

  ///
  final DateTime date;

  const Operation({
    required this.id,
    required this.path,
    required this.file,
    required this.state,
    required this.type,
    required this.date,
    this.error,
  });

  factory Operation.empty() {
    return Operation(
      id: 0,
      path: '',
      file: BacFile.empty(),
      state: OperationState.created,
      type: OperationType.upload,
      date: DateTime.now(),
    );
  }

  Operation copyWith({
    int? id,
    String? path,
    String? error,
    BacFile? file,
    OperationState? state,
    OperationType? type,
    DateTime? date,
  }) {
    return Operation(
      id: id ?? this.id,
      path: path ?? this.path,
      error: error ?? this.error,
      file: file ?? this.file,
      state: state ?? this.state,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, path, file, state, type];
}
