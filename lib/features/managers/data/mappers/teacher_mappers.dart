import 'package:bac_files_admin/features/managers/data/models/file_teacher_model.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';

extension FileTeacherMapper on FileTeacher {
  FileTeacherModel get toModel {
    return FileTeacherModel(
      id: id,
      name: name,
    );
  }
}

extension TeacherModelMapper on FileTeacherModel {
  FileTeacher get toEntity {
    return FileTeacher(
      id: id,
      name: name,
    );
  }
}
