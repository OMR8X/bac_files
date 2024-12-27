import 'package:bac_files/features/managers/data/mappers/teacher_mappers.dart';
import 'package:bac_files/features/managers/data/models/file_teacher_model.dart';
import 'package:bac_files/features/managers/domain/entities/teacher.dart';

import 'managers_base_converter.dart';

class FileTeacherConverter extends ManagersBaseConverter<FileTeacher> {
  @override
  FileTeacher fromJson(Map<String, dynamic> json) {
    return FileTeacherModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FileTeacher entity) {
    return entity.toModel.toJson();
  }
}
