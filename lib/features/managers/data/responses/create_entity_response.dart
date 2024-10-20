import '../../../../core/services/api/responses/api_response.dart';

class CreateEntityResponse {
  final String message;

  CreateEntityResponse({required this.message});

  factory CreateEntityResponse.fromApiResponse({required ApiResponse response}) {
    return CreateEntityResponse(message: response.message);
  }
}
