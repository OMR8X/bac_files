import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/entities/operation_state.dart';

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
