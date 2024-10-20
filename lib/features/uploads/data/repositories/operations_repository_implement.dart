import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/uploads/data/datasources/operations_local_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/operation_state.dart';
import '../../domain/entities/upload_operation.dart';
import '../../domain/repositories/operations_repository.dart';

class OperationsRepositoryImplement implements OperationsRepository {
  final OperationsLocalDataSource _localDataSource;

  OperationsRepositoryImplement({
    required OperationsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;
  @override
  Future<Either<Failure, Unit>> addOperation({required UploadOperation operation}) async {
    try {
      await _localDataSource.addOperation(operation);
      return right(unit);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOperations({required int operationId}) async {
    try {
      await _localDataSource.deleteOperation(operationId);
      return right(unit);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, UploadOperation>> getOperation({required int operationId}) async {
    try {
      final response = await _localDataSource.getOperation(operationId: operationId);
      return right(response);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadOperation>>> getAllOperations() async {
    try {
      final response = await _localDataSource.getOperations();
      return right(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateOperation({required UploadOperation operation}) async {
    try {
      await _localDataSource.updateOperation(operation);
      return right(unit);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAllOperationsState({required OperationState state}) async {
    try {
      await _localDataSource.updateAllOperationsState(state);
      return right(unit);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }
}
