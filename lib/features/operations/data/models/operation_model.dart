import 'package:bac_files_admin/features/files/data/mappers/bac_file_mapper.dart';
import 'package:bac_files_admin/features/operations/data/mappers/operation_state_mapper.dart';
import 'package:bac_files_admin/features/operations/data/mappers/operation_type_mapper.dart';

import '../../../files/data/models/bac_file_model.dart';
import '../../domain/entities/operation.dart';

class OperationModel extends Operation {
  const OperationModel({
    required super.id,
    required super.path,
    required super.file,
    required super.state,
    required super.type,
    required super.date,
    super.error,
  });
  factory OperationModel.fromJson(Map json) {
    return OperationModel(
      id: json['id'],
      path: json['path'],
      error: json['error'],
      date: DateTime.parse(json['date']),
      file: BacFileModel.fromJson(json['file']),
      state: (json['state'] as String).toOperationState,
      type: (json['type'] as String).toOperationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'error': error,
      'file': file.toModel.toJson(),
      'state': state.name,
      'type': type.name,
      'date': date.toString(),
    };
  }
}
