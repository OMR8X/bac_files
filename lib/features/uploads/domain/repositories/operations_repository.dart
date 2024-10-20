import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/operation_state.dart';
import '../entities/upload_operation.dart';

abstract class OperationsRepository {
  /// get operation
  Future<Either<Failure, UploadOperation>> getOperation({required int operationId});

  /// get operations
  Future<Either<Failure, List<UploadOperation>>> getAllOperations();

  /// add operation
  Future<Either<Failure, Unit>> addOperation({required UploadOperation operation});

  /// update operation
  Future<Either<Failure, Unit>> updateOperation({required UploadOperation operation});

  /// update all operations state
  Future<Either<Failure, Unit>> updateAllOperationsState({required OperationState state});

  /// delete operation
  Future<Either<Failure, Unit>> deleteOperations({required int operationId});
}
