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
  Future<Either<Failure, List<UploadOperation>>> addOperation({required UploadOperation operation}) async {
    try {
      var response = await _localDataSource.addOperation(operation);
      return right(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadOperation>>> addOperations({required List<UploadOperation> operations}) async {
    try {
      var response = await _localDataSource.addOperations(operations);
      return right(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadOperation>>> deleteOperations({required int operationId}) async {
    try {
      var response = await _localDataSource.deleteOperation(operationId);
      return right(response);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadOperation>>> deleteAllOperations() async {
    try {
      var response = await _localDataSource.deleteAllOperation();
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, UploadOperation>> getOperation({required int operationId}) async {
    try {
      final response = await _localDataSource.getOperation(operationId: operationId);
      return right(response);
    } on Exception {
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
  Future<Either<Failure, List<UploadOperation>>> updateOperation({required UploadOperation operation}) async {
    try {
      var response = await _localDataSource.updateOperation(operation);
      return right(response);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<UploadOperation>>> updateAllOperationsState({required OperationState state}) async {
    try {
      var response = await _localDataSource.updateAllOperationsState(state);
      return right(response);
    } on Exception {
      // TODO: Handle exception
      return left(const AnonFailure());
    }
  }
}
