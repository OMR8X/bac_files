import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:dartz/dartz.dart';
import '../entities/operation.dart';
import '../entities/operation_state.dart';

abstract class OperationsRepository {
  /// get operation
  Future<Either<Failure, Operation>> getOperation({required int operationId});

  /// get operations
  Future<Either<Failure, List<Operation>>> getAllOperations({required OperationType type});

  /// add operation
  Future<Either<Failure, Operation>> addOperation({required Operation operation});

  /// add operations
  Future<Either<Failure, List<Operation>>> addOperations({required List<Operation> operations});

  /// update operation
  Future<Either<Failure, List<Operation>>> updateOperation({required Operation operation});

  /// update all operations state
  Future<Either<Failure, List<Operation>>> updateAllOperationsState({required OperationState state, required OperationType type});

  /// delete operation
  Future<Either<Failure, Operation>> deleteOperation({required int operationId});
  Future<Either<Failure, List<Operation>>> deleteAllOperations({required OperationType type});
}
