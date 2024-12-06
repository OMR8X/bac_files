import '../../../../core/services/api/responses/api_response.dart';
import '../../domain/entites/user_data.dart';
import '../models/user_data_model.dart';

class GetUserDataResponse {
  final String message;
  final String token;
  final UserData user;

  GetUserDataResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory GetUserDataResponse.fromResponse(ApiResponse response) {
    return GetUserDataResponse(
      message: response.message,
      token: response.getData(key: "token"),
      user: UserDataModel.fromJson(response.getData(key: "user")),
    );
  }
}
