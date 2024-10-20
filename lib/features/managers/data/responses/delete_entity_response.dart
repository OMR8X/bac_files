import '../../../../core/services/api/responses/api_response.dart';

class DeleteEntityResponse {
  final String message;

  DeleteEntityResponse({required this.message});

  factory DeleteEntityResponse.fromApiResponse({required ApiResponse response}) {
    return DeleteEntityResponse(message: response.message);
  }
}
