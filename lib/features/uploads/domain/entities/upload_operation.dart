import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'operation_state.dart';

class UploadOperation extends Equatable {
  ///
  final int id;

  ///
  final String path;

  ///
  final BacFile file;

  ///
  final OperationState state;

  ///
  final String? error;

  const UploadOperation({
    required this.id,
    required this.path,
    required this.file,
    required this.state,
    this.error,
  });

  factory UploadOperation.empty() {
    return UploadOperation(
      id: 0,
      path: '',
      file: BacFile.empty(),
      state: OperationState.initializing,
    );
  }

  UploadOperation copyWith({
    int? id,
    String? path,
    String? error,
    BacFile? file,
    OperationState? state,
  }) {
    return UploadOperation(
      id: id ?? this.id,
      path: path ?? this.path,
      error: error ?? this.error,
      file: file ?? this.file,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [id, path, file, state];
}
