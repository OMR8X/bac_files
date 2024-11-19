import 'package:bac_files_admin/features/uploads/data/models/upload_operation_model.dart';

import '../../domain/entities/upload_operation.dart';

extension UploadOperationMapper on UploadOperation {
  UploadOperationModel get toModel {
    return UploadOperationModel(
      id: id,
      path: path,
      file: file,
      state: state,
      error: error,
    );
  }
}

extension UploadOperationModelMapper on UploadOperationModel {
  UploadOperation get toEntity {
    return UploadOperation(
      id: id,
      path: path,
      file: file,
      state: state,
      error: error,
    );
  }
}
