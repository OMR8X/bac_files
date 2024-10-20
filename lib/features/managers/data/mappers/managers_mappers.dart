import 'package:bac_files_admin/features/managers/data/models/category_model.dart';
import 'package:bac_files_admin/features/managers/data/models/managers_model.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';

extension ManagerMapper on FileManagers {
  FileManagersModel get toModel {
    return FileManagersModel(
      categories: categories,
      materials: materials,
      schools: schools,
      sections: sections,
      teachers: teachers,
    );
  }
}

extension ManagerModelMapper on FileManagersModel {
  FileManagers get toEntity {
    return FileManagers(
      categories: categories,
      materials: materials,
      schools: schools,
      sections: sections,
      teachers: teachers,
    );
  }
}
