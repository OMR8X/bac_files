import 'package:bac_files_admin/features/managers/data/mappers/material_mappers.dart';
import 'package:bac_files_admin/features/managers/data/models/file_material_model.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';

import 'managers_base_converter.dart';

class FileMaterialConverter extends ManagersBaseConverter<FileMaterial> {
  @override
  FileMaterial fromJson(Map<String, dynamic> json) {
    return FileMaterialModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FileMaterial entity) {
    return entity.toModel.toJson();
  }
}
