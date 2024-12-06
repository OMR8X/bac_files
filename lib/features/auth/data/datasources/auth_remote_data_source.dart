import 'package:bac_files_admin/features/auth/data/responses/change_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_files_admin/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_files_admin/features/auth/domain/requests/sign_out_request.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entites/user_data.dart';
import '../../domain/requests/change_password_request.dart';
import '../../domain/requests/forget_password_request.dart';
import '../../domain/requests/sign_in_request.dart';
import '../../domain/requests/sign_up_request.dart';
import '../../domain/requests/update_user_data_request.dart';

abstract class AuthRemoteDataSource {
  // change user password
  Future<ChangePasswordResponse> changePassword({
    required ChangePasswordRequest request,
  });
  // send code to user via email to reset password.
  Future<ForgetPasswordResponse> forgetPassword({
    required ForgetPasswordRequest request,
  });
  // signing in
  Future<SignInResponse> signIn({
    required SignInRequest request,
  });
  // signing up
  Future<SignUpResponse> signUp({
    required SignUpRequest request,
  });
  // update user data
  Future<UpdateUserDataResponse> updateUserData({
    required UpdateUserDataRequest request,
  });
  // update user data
  Future<SignOutResponse> signOut({
    required SignOutRequest request,
  });
  //
  // update user data
  Future<GetUserDataResponse> getUserData({
    required GetUserDataRequest request,
  });
}
