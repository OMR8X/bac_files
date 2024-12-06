import 'dart:async';

import 'package:bac_files_admin/features/managers/data/converters/managers_base_converter.dart';
import 'package:bac_files_admin/features/managers/data/responses/select_entity_response.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entity_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/errors/exceptions.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../main.dart';
import '../../domain/repositories/managers_repository.dart';
import '../../domain/requests/create_entity_request.dart';
import '../../domain/requests/delete_entity_request.dart';
import '../../domain/requests/select_entities_request.dart';
import '../../domain/requests/update_entity_request.dart';
import '../datasources/managers_remote_datasource.dart';
import '../responses/create_entity_response.dart';
import '../responses/delete_entity_response.dart';
import '../responses/select_entities_response.dart';
import '../responses/update_entity_response.dart';

class ManagersRepositoryImplement implements ManagersRepository {
  final ManagersRemoteDataSource remoteDataSource;

  ManagersRepositoryImplement({required this.remoteDataSource});
  @override
  Future<Either<Failure, CreateEntityResponse>> createEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required CreateEntityRequest<T> request,
  }) async {
    try {
      final response = await remoteDataSource.createEntity<T>(
        request: request,
        apiEndpoint: apiEndpoint,
        converter: converter,
      );
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      //

      //
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, DeleteEntityResponse>> deleteEntity<T>({
    required String apiEndpoint,
    required DeleteEntityRequest request,
  }) async {
    try {
      final response = await remoteDataSource.deleteEntity<T>(
        request: request,
        apiEndpoint: apiEndpoint,
      );
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      //

      //
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, SelectEntitiesResponse<T>>> selectEntities<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntitiesRequest request,
  }) async {
    try {
      final response = await remoteDataSource.selectEntities<T>(
        request: request,
        apiEndpoint: apiEndpoint,
        converter: converter,
      );
      return right(response);
      //
    } on DioException catch (e) {
      await ErrorsCopier().addErrorLogs("${e.toString()}\n ${e.stackTrace.toString()}");
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException catch (e) {
      await ErrorsCopier().addErrorLogs(e.toString());
      return left(ServerFailure(message: e.message));
      //
    } on AuthException catch (e) {
      await ErrorsCopier().addErrorLogs(e.toString());
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      //

      await ErrorsCopier().addErrorLogs(e.toString());
      //
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, SelectEntityResponse<T>>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  }) async {
    try {
      final response = await remoteDataSource.selectEntity<T>(
        request: request,
        apiEndpoint: apiEndpoint,
        converter: converter,
      );
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      //

      //
      return left(const AnonFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateEntityResponse>> updateEntity<T>({
    required String apiEndpoint,
    required UpdateEntityRequest<T> request,
    required ManagersBaseConverter<T> converter,
  }) async {
    try {
      final response = await remoteDataSource.updateEntity<T>(
        request: request,
        apiEndpoint: apiEndpoint,
        converter: converter,
      );
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      //

      //
      return left(const AnonFailure());
    }
  }
}
