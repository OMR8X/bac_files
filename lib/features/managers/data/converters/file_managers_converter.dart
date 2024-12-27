import 'package:bac_files/features/managers/data/mappers/managers_mappers.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';

import '../models/managers_model.dart';
import 'managers_base_converter.dart';

class FileManagersConverter extends ManagersBaseConverter<FileManagers> {
  @override
  FileManagers fromJson(Map<String, dynamic> json) {
    return FileManagersModel.fromJson(json["managers"]);
  }

  @override
  Map<String, dynamic> toJson(FileManagers entity) {
    return entity.toModel.toJson();
  }
}
