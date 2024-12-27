import 'dart:convert';

import 'package:bac_files/core/services/api/responses/api_response.dart';

import '../converters/managers_base_converter.dart';

class SelectEntityResponse<Entity> {
  final Entity entity;

  SelectEntityResponse({required this.entity});

  //
  factory SelectEntityResponse.fromApiResponse({
    required ApiResponse response,
    required ManagersBaseConverter<Entity> converter,
  }) {
    return SelectEntityResponse(
      entity: converter.fromJson(response.data.first),
    );
  }
  //
  factory SelectEntityResponse.fromCache({
    required dynamic data,
    required ManagersBaseConverter<Entity> converter,
  }) {
    return SelectEntityResponse(
      entity: converter.fromJson(json.decode(data)),
    );
  }
}
