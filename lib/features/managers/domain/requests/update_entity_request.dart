import 'package:bac_files/features/managers/data/converters/managers_base_converter.dart';

class UpdateEntityRequest<Entity> {
  final String id;
  final Entity entity;

  UpdateEntityRequest({
    required this.id,
    required this.entity,
  });

  Map<String, dynamic> toBody({
    required ManagersBaseConverter<Entity> converter,
  }) {
    return converter.toJson(entity);
  }
}
