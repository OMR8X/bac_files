import 'package:bac_files/features/managers/data/models/managers_model.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';

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
