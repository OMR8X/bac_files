import 'package:bac_files/features/operations/domain/entities/operation_type.dart';

import '../../../operations/domain/entities/operation.dart';

abstract class BackgroundMessengerRepository {
  //
  Future<void> sendUpdateState({List<Operation>? operations, required OperationType type});
  //
  Future<void> sendOperationFailed({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
  });
  //
  Future<void> sendOperationCompletedMessage({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
  });
  //
  Future<void> sendProgressMessageMessage({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
    required int sent,
    required int total,
  });
}
