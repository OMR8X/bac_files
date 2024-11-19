import 'package:bac_files_admin/core/resources/errors/exceptions.dart';
import 'package:bac_files_admin/features/uploads/data/mappers/upload_operation_mapper.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/cache/cache_manager.dart';
import '../../domain/entities/upload_operation.dart';
import '../models/upload_operation_model.dart';

abstract class OperationsLocalDataSource {
  ///
  Future<UploadOperation> getOperation({required int operationId});

  ///
  Future<List<UploadOperation>> getOperations();

  ///
  Future<List<UploadOperation>> addOperation(UploadOperation operation);

  ///
  Future<List<UploadOperation>> addOperations(List<UploadOperation> operations);

  ///
  Future<List<UploadOperation>> updateOperation(UploadOperation operation);

  ///
  Future<List<UploadOperation>> updateAllOperationsState(OperationState state);

  ///
  Future<List<UploadOperation>> deleteOperation(int operationId);

  ///
  Future<List<UploadOperation>> deleteAllOperation();
}

class OperationsLocalDataSourceImplement implements OperationsLocalDataSource {
  ///
  final CacheManager _cacheManager;

  ///
  OperationsLocalDataSourceImplement({
    required CacheManager cacheManager,
  }) : _cacheManager = cacheManager;

  ///
  @override
  Future<List<UploadOperation>> addOperation(UploadOperation operation) async {
    ///
    /// get local operations
    List<UploadOperation> localOperations = await _getOperations();

    ///
    /// generate id based on current time (milliseconds since epoch) and limit to 6 digits
    int id = DateTime.now().millisecondsSinceEpoch % 1000000;

    ///
    /// check if the generated id already exists in local operations
    while (localOperations.any((op) => op.id == id)) {
      id = (id + 1) % 1000000; // increment id and wrap around if necessary
    }

    ///
    /// add new operation with the generated id
    localOperations.add(operation.copyWith(id: id));

    ///
    /// set local operations
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<List<UploadOperation>> addOperations(List<UploadOperation> operations) async {
    ///
    /// get local operations
    List<UploadOperation> localOperations = await _getOperations();

    ///
    /// generate id based on current time (milliseconds since epoch) and limit to 6 digits
    int id = DateTime.now().millisecondsSinceEpoch % 1000000;

    ///
    /// check if the generated id already exists in local operations
    while (localOperations.any((op) => op.id == id)) {
      id = (id + 1) % 1000000; // increment id and wrap around if necessary
    }

    ///
    for (var operation in operations) {
      localOperations.add(operation.copyWith(id: id));
      id++;
    }

    ///
    /// set local operations
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<List<UploadOperation>> updateOperation(UploadOperation operation) async {
    ///
    /// get local operations
    List<UploadOperation> localOperations = await _getOperations();

    ///
    /// update operation
    for (int i = 0; i < localOperations.length; i++) {
      if (localOperations[i].id == operation.id) {
        debugPrint('updateOperation operation: ${operation.error}');
        localOperations[i] = operation;
      }
    }

    ///

    ///
    /// set local operations
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<List<UploadOperation>> deleteOperation(int operationId) async {
    print("tick 1");

    ///
    List<UploadOperation> localOperations = await _getOperations();
    print("tick 2");

    ///
    /// add new operation
    localOperations.removeWhere((e) => e.id == operationId);
    print("tick 3");

    ///
    /// mapping
    await _setOperations(localOperations);
    print("tick 4");

    ///
    print("tick 5");
    return localOperations;
  }

  ///
  @override
  Future<List<UploadOperation>> deleteAllOperation() async {
    ///
    List<UploadOperation> localOperations = await _getOperations();

    ///
    /// add new operation
    localOperations.removeWhere((e) => true);

    ///
    /// mapping
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<List<UploadOperation>> getOperations() async {
    return await _getOperations();
  }

  @override
  Future<UploadOperation> getOperation({required int operationId}) async {
    //
    final operation = (await _getOperations()).where((e) => e.id == operationId).firstOrNull;
    //
    if (operation == null) {
      throw const ItemNotExistsException();
    }
    //
    return operation;
  }

  Future<List<UploadOperation>> _getOperations() async {
    //
    await _cacheManager.refresh();
    //
    await Future.delayed(Durations.medium4);
    //
    /// get local operations
    List localData = await _cacheManager().read('operations') ?? [];

    ///
    /// mapping
    List<UploadOperation> operations = localData.map((e) {
      return UploadOperationModel.fromJson(e).toEntity;
    }).toList();

    ///
    return operations;
  }

  Future<List<UploadOperation>> _setOperations(List<UploadOperation> operations) async {
    ///
    /// mapping
    List<Map<String, dynamic>> localData = operations.map((e) {
      return e.toModel.toJson();
    }).toList();

    ///
    await _cacheManager().write('operations', localData);

    ///
    return operations;
  }

  @override
  Future<List<UploadOperation>> updateAllOperationsState(OperationState state) async {
    //
    final List<UploadOperation> operations = await _getOperations();
    //
    for (int i = 0; i < operations.length; i++) {
      if (operations[i].state != OperationState.succeed && operations[i].state != OperationState.created) {
        operations[i] = operations[i].copyWith(state: state);
      }
    }
    //
    await _setOperations(operations);
    //
    return operations;
  }
}
