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
  Future<Either<Failure, List<UploadOperation>>> addOperation({required UploadOperation operation});

  /// add operations
  Future<Either<Failure, List<UploadOperation>>> addOperations({required List<UploadOperation> operations});

  /// update operation
  Future<Either<Failure, List<UploadOperation>>> updateOperation({required UploadOperation operation});

  /// update all operations state
  Future<Either<Failure, List<UploadOperation>>> updateAllOperationsState({required OperationState state});

  /// delete operation
  Future<Either<Failure, List<UploadOperation>>> deleteOperations({required int operationId});
  Future<Either<Failure, List<UploadOperation>>> deleteAllOperations();
}
