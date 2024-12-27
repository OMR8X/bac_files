import 'package:bac_files/features/managers/data/mappers/category_mappers.dart';
import 'package:bac_files/features/managers/domain/entities/file_category.dart';

import '../models/category_model.dart';
import 'managers_base_converter.dart';

class FileCategoryConverter extends ManagersBaseConverter<FileCategory> {
  @override
  FileCategory fromJson(Map<String, dynamic> json) {
    return FileCategoryModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FileCategory entity) {
    return entity.toModel.toJson();
  }
}
