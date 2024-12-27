import 'package:bac_files/features/managers/data/models/file_material_model.dart';
import 'package:bac_files/features/managers/domain/entities/file_material.dart';

extension MaterialMapper on FileMaterial {
  FileMaterialModel get toModel {
    return FileMaterialModel(
      id: id,
      name: name,
    );
  }
}

extension FileMaterialModelMapper on FileMaterialModel {
  FileMaterial get toEntity {
    return FileMaterial(
      id: id,
      name: name,
    );
  }
}
