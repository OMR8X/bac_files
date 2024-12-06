import 'dart:io';

import 'package:bac_files_admin/features/operations/data/mappers/operation_mapper.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/errors/exceptions.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../domain/entities/operation.dart';
import '../../domain/entities/operation_state.dart';
import '../../domain/entities/operation_type.dart';
import '../models/operation_model.dart';

abstract class OperationsLocalDataSource {
  ///
  Future<Operation> getOperation({required int operationId});

  ///
  Future<List<Operation>> getOperations();

  ///
  Future<Operation> addOperation(Operation operation);

  ///
  Future<List<Operation>> addOperations(List<Operation> operations);

  ///
  Future<List<Operation>> updateOperation(Operation operation);

  ///
  Future<List<Operation>> updateAllOperationsState(OperationState state, OperationType type);

  ///
  Future<Operation?> deleteOperation(int operationId);

  ///
  Future<List<Operation>> deleteAllOperation(OperationType type);
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
  Future<Operation> addOperation(Operation operation) async {
    ///
    /// get local operations
    List<Operation> localOperations = await _getOperations();

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
    return operation.copyWith(id: id);
  }

  ///
  @override
  Future<List<Operation>> addOperations(List<Operation> operations) async {
    ///
    /// get local operations
    List<Operation> localOperations = await _getOperations();

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
  Future<List<Operation>> updateOperation(Operation operation) async {
    ///
    /// get local operations
    List<Operation> localOperations = await _getOperations();

    ///
    /// update operation
    for (int i = 0; i < localOperations.length; i++) {
      if (localOperations[i].id == operation.id) {
        localOperations[i] = operation;
      }
    }

    ///
    /// set local operations
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<Operation?> deleteOperation(int operationId) async {
    ///
    List<Operation> localOperations = await _getOperations();

    ///
    Operation? operation;

    ///
    /// add new operation
    localOperations.removeWhere(
      (e) {
        bool delete = e.id == operationId;
        if (delete) {
          operation = e;
          return true;
        } else {
          return false;
        }
      },
    );

    ///
    if (operation != null && operation?.type == OperationType.download) {
      if (await File(operation!.path).exists()) {
        await File(operation!.path).delete();
      }
    }

    ///
    /// mapping
    await _setOperations(localOperations);

    ///
    return operation;
  }

  ///
  @override
  Future<List<Operation>> deleteAllOperation(OperationType type) async {
    ///
    List<Operation> localOperations = await _getOperations();

    ///
    List<Operation> toDeleteOperations = [];

    ///
    /// add new operation
    localOperations.removeWhere(
      (e) {
        bool delete = e.type == type;
        if (delete) {
          toDeleteOperations.add(e);
          return true;
        } else {
          return false;
        }
      },
    );

    for (Operation o in toDeleteOperations) {
      if (await File(o.path).exists()) {
        await File(o.path).delete();
      }
    }

    ///
    /// mapping
    await _setOperations(localOperations);

    ///
    return localOperations;
  }

  ///
  @override
  Future<List<Operation>> getOperations() async {
    return await _getOperations();
  }

  @override
  Future<Operation> getOperation({required int operationId}) async {
    //
    final operation = (await _getOperations()).where((e) => e.id == operationId).firstOrNull;
    //
    if (operation == null) {
      throw const ItemNotExistsException();
    }
    //
    return operation;
  }

  Future<List<Operation>> _getOperations() async {
    //
    await _cacheManager.refresh();
    //
    await Future.delayed(Durations.medium4);
    //
    /// get local operations
    List localData = await _cacheManager().read('operations') ?? [];

    ///
    /// mapping
    List<Operation> operations = localData.map((e) {
      return OperationModel.fromJson(e).toEntity;
    }).toList();

    ///
    return operations;
  }

  Future<List<Operation>> _setOperations(List<Operation> operations) async {
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
  Future<List<Operation>> updateAllOperationsState(OperationState state, OperationType type) async {
    //
    final List<Operation> operations = await _getOperations();
    //
    for (int i = 0; i < operations.length; i++) {
      if (operations[i].state != OperationState.succeed && operations[i].state != OperationState.created) {
        if (operations[i].type == type) {
          operations[i] = operations[i].copyWith(state: state);
        }
      }
    }
    //
    await _setOperations(operations);
    //
    return operations;
  }
}
