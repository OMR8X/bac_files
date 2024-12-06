import 'dart:async';

import 'package:bac_files_admin/features/auth/data/datasources/auth_remote_data_source.dart';
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

import '../../../../core/resources/errors/failures.dart';
import '../../domain/entites/user_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/requests/change_password_request.dart';
import '../../domain/requests/forget_password_request.dart';
import '../../domain/requests/sign_in_request.dart';
import '../../domain/requests/sign_up_request.dart';
import '../../domain/requests/update_user_data_request.dart';
import '../datasources/auth_remote_data_source_implements.dart';

class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImplement({
    required this.remoteDataSource,
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
    } on ServerException {
      return left(const ServerFailure());
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
    } on ServerException {
      return left(const ServerFailure());
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
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException {
      return left(const ServerFailure());
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
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException {
      return left(const ServerFailure());
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
  Future<Either<Failure, UpdateUserDataResponse>> updateUserData({
    required UpdateUserDataRequest request,
  }) async {
    try {
      final response = await remoteDataSource.updateUserData(request: request);
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException {
      return left(const ServerFailure());
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
      return right(response);
      //
    } on DioException catch (e) {
      return left(ServerFailure(message: e.message));
      //
    } on TimeoutException {
      return left(const TimeOutFailure());
      //
    } on ServerException {
      return left(const ServerFailure());
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
    } on ServerException {
      return left(const ServerFailure());
      //
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
      //
    } catch (e) {
      return left(const AnonFailure());
    }
  }
}
