import '../../domain/entities/operation.dart';
import '../models/operation_model.dart';

extension OperationMapper on Operation {
  OperationModel get toModel {
    return OperationModel(
      id: id,
      path: path,
      file: file,
      state: state,
      type: type,
      error: error,
    );
  }
}

extension OperationModelMapper on OperationModel {
  Operation get toEntity {
    return Operation(
      id: id,
      path: path,
      file: file,
      state: state,
      type: type,
      error: error,
    );
  }
}
