import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/data/models/category_model.dart';

class BacFileModel extends BacFile {
  const BacFileModel({
    required super.id,
    required super.title,
    required super.size,
    required super.extension,
    super.year,
    super.sectionId,
    super.materialId,
    super.teacherId,
    super.schoolId,
    required super.categoriesIds,
  });

  factory BacFileModel.fromJson(Map json) {
    //
    List<String> categoriesId = List.empty(growable: true);
    if (json['categories'] != null) {
      categoriesId.removeWhere((e) => true);
      for (var item in (json['categories'] as List)) {
        categoriesId.add(FileCategoryModel.fromJson(item).id);
      }
    }
    if (json['categories_ids'] != null) {
      categoriesId.removeWhere((e) => true);
      for (var item in (json['categories_ids'] as List)) {
        categoriesId.add(item);
      }
    }
    //
    return BacFileModel(
      id: json['id'].toString(),
      title: json['title'],
      size: json['size'].toString(),
      extension: json['extension'].toString(),
      year: json['year']?.toString(),
      sectionId: json['section_id']?.toString(),
      materialId: json['material_id']?.toString(),
      teacherId: json['teacher_id']?.toString(),
      schoolId: json['school_id']?.toString(),
      categoriesIds: categoriesId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'size': size,
      'extension': extension,
      'year': year,
      'section_id': sectionId,
      'material_id': materialId,
      'teacher_id': teacherId,
      'school_id': schoolId,
      'categories_ids': categoriesIds,
    };
  }
}
