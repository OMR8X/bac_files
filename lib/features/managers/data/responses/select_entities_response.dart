import 'package:bac_files_admin/core/services/api/responses/api_response.dart';
import 'package:bac_files_admin/features/managers/data/converters/managers_base_converter.dart';

class SelectEntitiesResponse<Entity> {
  final List<Entity> entities;

  SelectEntitiesResponse({required this.entities});

  //
  factory SelectEntitiesResponse.fromApiResponse({
    required ApiResponse response,
    required ManagersBaseConverter<Entity> converter,
  }) {
    return SelectEntitiesResponse(
      entities: List<Entity>.from((response.data).map((item) => converter.fromJson(item))),
    );
  }
}
