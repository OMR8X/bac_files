import 'package:bac_files/features/managers/data/models/category_model.dart';
import 'package:bac_files/features/managers/domain/entities/file_category.dart';

extension CategoryMapper on FileCategory {
  FileCategoryModel get toModel {
    return FileCategoryModel(
      id: id,
      name: name,
    );
  }
}

extension CategoryModelMapper on FileCategoryModel {
  FileCategory get toEntity {
    return FileCategory(
      id: id,
      name: name,
    );
  }
}
