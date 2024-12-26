import 'package:bac_files_admin/features/auth/data/responses/change_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_files_admin/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_files_admin/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_files_admin/features/auth/domain/requests/sign_out_request.dart';
import '../../../../core/services/api/api_constants.dart';
import '../../../../core/services/api/api_manager.dart';
import '../../../../core/services/api/responses/api_response.dart';
import '../../../../core/services/tokens/tokens_manager.dart';
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

class AuthRemoteDataSourceImplements implements AuthRemoteDataSource {
  final ApiManager apiManager;

  AuthRemoteDataSourceImplements({required this.apiManager});

  @override
  Future<ChangePasswordResponse> changePassword({
    required ChangePasswordRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.changePassword,
      body: request.toBody(),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    return ChangePasswordResponse.fromResponse(apiResponse);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword({
    required ForgetPasswordRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.forgetPassword,
      body: request.toBody(),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    return ForgetPasswordResponse.fromResponse(apiResponse);
  }

  @override
  Future<SignInResponse> signIn({
    required SignInRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.signIn,
      body: request.toBody(),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    final response = SignInResponse.fromResponse(apiResponse);
    //
    return response;
  }

  @override
  Future<SignUpResponse> signUp({
    required SignUpRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.signUp,
      body: request.toBody(),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    final response = SignUpResponse.fromResponse(apiResponse);
    //
    return response;
  }

  @override
  Future<GetUserDataResponse> getUserData({
    required GetUserDataRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.getUserData,
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    return GetUserDataResponse.fromResponse(apiResponse);
  }

  @override
  Future<SignOutResponse> signOut({required SignOutRequest request}) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.signOut,
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //
    // delete token
    await TokenManager().deleteToken();
    //
    return SignOutResponse.fromResponse(apiResponse);
  }

  @override
  Future<UpdateUserDataResponse> updateUserData({
    required UpdateUserDataRequest request,
  }) async {
    //
    final dioResponse = await apiManager().post(
      ApiEndpoints.updateUserData,
      body: request.toBody(),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    //
    apiResponse.throwErrorIfExists();
    //

    //
    return UpdateUserDataResponse.fromResponse(apiResponse);
    //
  }
}
