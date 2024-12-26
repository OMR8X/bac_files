import 'dart:async';
import 'dart:convert';

import 'package:bac_files_admin/core/services/cache/cache_constant.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bac_files_admin/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bac_files_admin/features/auth/data/mappers/user_data_mapper.dart';
import 'package:bac_files_admin/features/auth/data/responses/change_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_files_admin/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_files_admin/features/auth/domain/requests/sign_out_request.dart';
import 'package:bac_files_admin/core/resources/errors/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/services/tokens/tokens_manager.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/requests/change_password_request.dart';
import '../../domain/requests/forget_password_request.dart';
import '../../domain/requests/sign_in_request.dart';
import '../../domain/requests/sign_up_request.dart';
import '../../domain/requests/update_user_data_request.dart';

class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final CacheManager cacheManager;

  AuthRepositoryImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.cacheManager,
  });

  @override
  Future<Either<Failure, ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request,
  }) async {
    try {
      final response = await remoteDataSource.changePassword(request: request);
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
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword({
    required ForgetPasswordRequest request,
  }) async {
    try {
      //
      final response = await remoteDataSource.forgetPassword(request: request);
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
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> signIn({
    required SignInRequest request,
  }) async {
    try {
      final response = await remoteDataSource.signIn(request: request);
      await TokenManager().setToken(token: response.token);
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
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, SignUpResponse>> signUp({
    required SignUpRequest request,
  }) async {
    try {
      final response = await remoteDataSource.signUp(request: request);
      await TokenManager().setToken(token: response.token);
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
      debugPrint(e.toString());
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, UpdateUserDataResponse>> updateUserData({
    required UpdateUserDataRequest request,
  }) async {
    try {
      final response = await remoteDataSource.updateUserData(request: request);
      await TokenManager().setToken(token: response.token);
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
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, GetUserDataResponse>> getUserData({
    required GetUserDataRequest request,
  }) async {
    try {
      final response = await remoteDataSource.getUserData(request: request);
      await cacheManager().write(CacheConstant.userDataDataKey, json.encode(response.user.toModel.toJson()));
      return right(response);
      //
    } on DioException catch (e) {
      try {
        final response = await localDataSource.getUserData(request: request);
        return right(response);
      } on Exception {
        return left(ServerFailure(message: e.message));
      }
      //
    } on TimeoutException {
      try {
        final response = await localDataSource.getUserData(request: request);
        return right(response);
      } on Exception {
        return left(const TimeOutFailure());
      }
      //
    } on ServerException catch (e) {
      try {
        final response = await localDataSource.getUserData(request: request);
        return right(response);
      } on Exception {
        return left(ServerFailure(message: e.message));
      }
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      return left(const AnonFailure());
      //
    }
  }

  @override
  Future<Either<Failure, SignOutResponse>> signOut({
    required SignOutRequest request,
  }) async {
    try {
      final response = await remoteDataSource.signOut(request: request);
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
      return left(const AnonFailure());
    }
  }
}
