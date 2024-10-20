
import '../../../../core/services/api/responses/api_response.dart';

class UpdateEntityResponse {
  final String message;

  UpdateEntityResponse({
    required this.message,
  });

  factory UpdateEntityResponse.fromApiResponse({required ApiResponse response}) {
    return UpdateEntityResponse(message: response.message);
  }
}
