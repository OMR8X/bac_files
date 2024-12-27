import 'package:bac_files/features/operations/domain/entities/operation_state.dart';

extension OperationStateMapper on String {
  OperationState get toOperationState {
    return OperationState.values.firstWhere(
      (state) => state.name == this,
      orElse: () {
        return OperationState.initializing;
      },
    );
  }
}
