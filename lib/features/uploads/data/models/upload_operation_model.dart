import 'package:bac_files_admin/features/files/data/mappers/bac_file_mapper.dart';
import 'package:bac_files_admin/features/uploads/data/mappers/upload_state_mapper.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';

import '../../../files/data/models/bac_file_model.dart';

class UploadOperationModel extends UploadOperation {
  const UploadOperationModel({
    required super.id,
    required super.path,
    required super.file,
    required super.state,
    super.error,
  });
  factory UploadOperationModel.fromJson(Map json) {
    return UploadOperationModel(
      id: json['id'],
      path: json['path'],
      error: json['error'],
      file: BacFileModel.fromJson(json['file']),
      state: (json['state'] as String).toOperationState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'error': error,
      'file': file.toModel.toJson(),
      'state': state.name,
    };
  }
}
