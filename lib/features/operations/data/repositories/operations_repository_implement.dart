import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/background_service/background_service.dart';
import 'package:bac_files_admin/core/services/background_service/messages/add_operations.dart';
import 'package:bac_files_admin/core/services/background_service/messages/remove_all_operations.dart';
import 'package:bac_files_admin/core/services/background_service/messages/remove_operations.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/services/debug/debugging_client.dart';
import '../../../../core/services/debug/debugging_manager.dart';
import '../../domain/entities/operation.dart';
import '../../domain/entities/operation_state.dart';
import '../../domain/repositories/operations_repository.dart';
import '../datasources/operations_local_datasource.dart';

class OperationsRepositoryImplement implements OperationsRepository {
  final OperationsLocalDataSource _localDataSource;

  OperationsRepositoryImplement({
    required OperationsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;
  @override
  Future<Either<Failure, Operation>> addOperation({required Operation operation}) async {
    try {
      //
      var response = await _localDataSource.addOperation(operation);
      //
      if (operation.type == OperationType.download) {
        //
        await sl<AppBackgroundService>().startBackgroundService();
        //
        FlutterBackgroundService().invoke(
          AddOperationsMessenger().channelName,
          AddOperationsMessenger().request(arguments: [response]),
        );
      }
      //
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> addOperations({required List<Operation> operations}) async {
    try {
      var response = await _localDataSource.addOperations(operations);
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Operation>> deleteOperation({required int operationId}) async {
    try {
      //
      var response = await _localDataSource.deleteOperation(operationId);
      //
      if (response == null) {
        return left(const ItemNotExistsFailure());
      }
      //
      await sl<AppBackgroundService>().startBackgroundService();
      //
      FlutterBackgroundService().invoke(
        RemoveOperationMessenger().channelName,
        RemoveOperationMessenger().request(arguments: [operationId]),
      );
      //
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> deleteAllOperations({required OperationType type}) async {
    try {
      //

      //
      await sl<AppBackgroundService>().startBackgroundService();
      //
      FlutterBackgroundService().invoke(
        RemoveAllOperationMessenger().channelName,
        RemoveAllOperationMessenger().request(arguments: type),
      );
      var response = await _localDataSource.deleteAllOperation(type);
      //

      //
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, Operation>> getOperation({required int operationId}) async {
    try {
      final response = await _localDataSource.getOperation(operationId: operationId);
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> getAllOperations({required OperationType type}) async {
    try {
      final response = await _localDataSource.getOperations();
      return right(response.where((e) => e.type == type).toList());
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> updateOperation({required Operation operation}) async {
    try {
      //
      var response = await _localDataSource.updateOperation(operation);
      //
      await sl<AppBackgroundService>().startBackgroundService();
      //
      if ([
        OperationState.created,
        OperationState.initializing,
        OperationState.succeed,
        OperationState.canceled,
        OperationState.failed,
      ].contains(operation.state)) {
        FlutterBackgroundService().invoke(
          RemoveOperationMessenger().channelName,
          RemoveOperationMessenger().request(arguments: [operation.id]),
        );
      }
      //
      if ([
        OperationState.pending,
        OperationState.uploading,
      ].contains(operation.state)) {
        FlutterBackgroundService().invoke(
          AddOperationsMessenger().channelName,
          AddOperationsMessenger().request(arguments: [operation]),
        );
      }

      //
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> updateAllOperationsState({required OperationState state, required OperationType type}) async {
    try {
      //

      //
      await sl<AppBackgroundService>().startBackgroundService();
      //
      if (![OperationState.pending, OperationState.uploading].contains(state)) {
        FlutterBackgroundService().invoke(
          RemoveAllOperationMessenger().channelName,
          RemoveAllOperationMessenger().request(arguments: type),
        );
      }
      //
      var response = await _localDataSource.updateAllOperationsState(state, type);
      //
      if ([OperationState.pending, OperationState.uploading].contains(state)) {
        FlutterBackgroundService().invoke(
          AddOperationsMessenger().channelName,
          AddOperationsMessenger().request(
            arguments: response.where((e) {
              return e.state == OperationState.pending || e.state == OperationState.uploading;
            }).toList(),
          ),
        );
      }
      //

      //
      return right(response);
    } on Exception {
      return left(const AnonFailure());
    }
  }
}
