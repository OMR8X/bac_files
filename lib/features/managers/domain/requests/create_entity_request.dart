import 'package:bac_files/features/managers/data/converters/managers_base_converter.dart';

class CreateEntityRequest<Entity> {
  final Entity entity;

  CreateEntityRequest({
    required this.entity,
  });

  Map<String, dynamic> toBody({
    required ManagersBaseConverter converter,
  }) {
    return converter.toJson(entity);
  }
}
