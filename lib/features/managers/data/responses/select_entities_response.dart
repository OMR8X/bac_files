import 'dart:convert';

import 'package:bac_files/core/services/api/responses/api_response.dart';
import 'package:bac_files/features/managers/data/converters/managers_base_converter.dart';

class SelectEntitiesResponse<Entity> {
  final int? lastPage;
  final List<Entity> entities;

  SelectEntitiesResponse({required this.entities, required this.lastPage});

  //
  factory SelectEntitiesResponse.fromApiResponse({
    required ApiResponse response,
    required ManagersBaseConverter<Entity> converter,
  }) {
    return SelectEntitiesResponse(
      lastPage: response.lastPage,
      entities: List<Entity>.from((response.data).map((item) => converter.fromJson(item))),
    );
  }
  //
  factory SelectEntitiesResponse.fromCache({
    required dynamic data,
    required ManagersBaseConverter<Entity> converter,
  }) {
    return SelectEntitiesResponse(
      lastPage: 0,
      entities: List<Entity>.from((json.decode(data)).map((item) => converter.fromJson(item))),
    );
  }
}
