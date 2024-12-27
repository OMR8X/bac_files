import 'package:bac_files/features/operations/domain/entities/operation_type.dart';

extension OperationTypeMapper on String {
  OperationType get toOperationType {
    return OperationType.values.firstWhere(
      (state) => state.name == this,
      orElse: () {
        return OperationType.upload;
      },
    );
  }
}
