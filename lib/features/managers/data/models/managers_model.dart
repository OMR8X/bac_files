import 'package:bac_files/features/managers/data/models/category_model.dart';
import 'package:bac_files/features/managers/data/models/file_material_model.dart';
import 'package:bac_files/features/managers/data/models/file_school_model.dart';
import 'package:bac_files/features/managers/data/models/file_section_model.dart';
import 'package:bac_files/features/managers/data/models/file_teacher_model.dart';
import 'package:bac_files/features/managers/domain/entities/file_category.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:bac_files/features/managers/domain/entities/file_material.dart';

import '../../domain/entities/school.dart';
import '../../domain/entities/file_section.dart';
import '../../domain/entities/teacher.dart';

class FileManagersModel extends FileManagers {
  FileManagersModel({
    required super.categories,
    required super.materials,
    required super.schools,
    required super.sections,
    required super.teachers,
  });

  factory FileManagersModel.fromJson(Map json) {
    return FileManagersModel(
      categories: List<FileCategory>.from(
        (json['categories'] as List<dynamic>).map((item) => FileCategoryModel.fromJson(item)),
      ),
      materials: List<FileMaterial>.from(
        (json['materials'] as List<dynamic>).map((item) => FileMaterialModel.fromJson(item)),
      ),
      schools: List<FileSchool>.from(
        (json['schools'] as List<dynamic>).map((item) => FileSchoolModel.fromJson(item)),
      ),
      sections: List<FileSection>.from(
        (json['sections'] as List<dynamic>).map((item) => FileSectionModel.fromJson(item)),
      ),
      teachers: List<FileTeacher>.from(
        (json['teachers'] as List<dynamic>).map((item) => FileTeacherModel.fromJson(item)),
      ),
    );
  }
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
