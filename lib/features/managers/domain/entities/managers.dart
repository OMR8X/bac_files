import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_section.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FileManagers extends Equatable {
  List<FileCategory> categories;
  List<FileMaterial> materials;
  List<FileSchool> schools;
  List<FileSection> sections;
  List<FileTeacher> teachers;

  FileManagers({
    required this.categories,
    required this.materials,
    required this.schools,
    required this.sections,
    required this.teachers,
  });

  FileManagers.empty()
      : categories = [],
        materials = [],
        schools = [],
        sections = [],
        teachers = [];

  void updateCategories(List<FileCategory> categories) {
    this.categories = categories;
  }

  void updateMaterials(List<FileMaterial> materials) {
    this.materials = materials;
  }

  void updateSchools(List<FileSchool> schools) {
    this.schools = schools;
  }

  void updateSections(List<FileSection> sections) {
    this.sections = sections;
  }

  void updateTeachers(List<FileTeacher> teachers) {
    this.teachers = teachers;
  }

  FileMaterial? materialById({required String? id, bool nullable = false}) {
    if (nullable) {
      return materials.where((e) => e.id == id).firstOrNull;
    }
    return materials.where((e) => e.id == id).firstOrNull ?? materials.first;
  }

  FileSchool? schoolById({required String? id, bool nullable = false}) {
    if (nullable) {
      return schools.where((e) => e.id == id).firstOrNull;
    }
    return schools.where((e) => e.id == id).firstOrNull ?? schools.first;
  }

  FileSection? sectionById({required String? id, bool nullable = false}) {
    if (nullable) {
      return sections.where((e) => e.id == id).firstOrNull;
    }
    return sections.where((e) => e.id == id).firstOrNull ?? sections.first;
  }

  FileTeacher? teacherById({required String? id, bool nullable = false}) {
    if (nullable) {
      return teachers.where((e) => e.id == id).firstOrNull;
    }
    return teachers.where((e) => e.id == id).firstOrNull ?? teachers.first;
  }

  FileCategory? categoryById({required String? id, bool nullable = false}) {
    if (nullable) {
      return categories.where((e) => e.id == id).firstOrNull;
    }
    return categories.where((e) => e.id == id).firstOrNull ?? categories.first;
  }

  List<FileCategory> categoriesByIds({required List<String> ids}) {
    //
    List<FileCategory> results = List.empty(growable: true);
    //
    for (var id in ids) {
      if (categories.any((e) => e.id == id)) {
        results.add(categories.firstWhere((e) => e.id == id));
      }
    }
    //
    return results;
  }

  @override
  List<Object?> get props => [categories, materials, schools, sections, teachers];
}
