import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/change_password_response.dart';
import '../../data/responses/forget_password_response.dart';
import '../../data/responses/get_user_data_response.dart';
import '../../data/responses/sign_in_response.dart';
import '../../data/responses/sign_out_response.dart';
import '../../data/responses/sign_up_response.dart';
import '../../data/responses/update_user_data_response.dart';
import '../requests/change_password_request.dart';
import '../requests/forget_password_request.dart';
import '../requests/get_user_data_request.dart';
import '../requests/sign_in_request.dart';
import '../requests/sign_out_request.dart';
import '../requests/sign_up_request.dart';
import '../requests/update_user_data_request.dart';

abstract class AuthRepository {
  // change user password
  Future<Either<Failure, ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request,
  });
  // send code to user via email to reset password.
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword({
    required ForgetPasswordRequest request,
  });
  // signing in
  Future<Either<Failure, SignInResponse>> signIn({
    required SignInRequest request,
  });
  // signing up
  Future<Either<Failure, SignUpResponse>> signUp({
    required SignUpRequest request,
  });
  // signing out
  Future<Either<Failure, SignOutResponse>> signOut({
    required SignOutRequest request,
  });
  // update user data
  Future<Either<Failure, UpdateUserDataResponse>> updateUserData({
    required UpdateUserDataRequest request,
  });
  //
  Future<Either<Failure, GetUserDataResponse>> getUserData({
    required GetUserDataRequest request,
  });
}
