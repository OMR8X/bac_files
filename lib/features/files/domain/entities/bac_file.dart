import 'dart:io';

import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_section.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/functions/extractors/extract_relevent_element_function.dart';
import '../../../../core/functions/formatters/normalize_file_name.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../core/services/api/api_constants.dart';
import '../../../managers/domain/entities/managers.dart';
import '../../../managers/domain/entities/teacher.dart';

class BacFile extends Equatable {
  final String id;
  final String title;
  final String size;
  final String extension;
  final String? year;
  final String? sectionId;
  final String? materialId;
  final String? teacherId;
  final String? schoolId;
  final List<String> categoriesIds;

  const BacFile({
    required this.id,
    required this.title,
    required this.size,
    required this.extension,
    this.year,
    this.sectionId,
    this.materialId,
    this.teacherId,
    this.schoolId,
    required this.categoriesIds,
  });

  String publicViewUrl() {
    return ApiEndpoints.viewPdf(id);
  }

  BacFile copyWith({
    String? id,
    String? title,
    String? size,
    String? extension,
    String? year,
    String? sectionId,
    String? materialId,
    String? teacherId,
    String? schoolId,
    bool setYearNull = false,
    bool setTeacherNull = false,
    bool setSchoolNull = false,
    List<String>? categoriesIds,
  }) {
    return BacFile(
      id: id ?? this.id,
      title: title ?? this.title,
      size: size ?? this.size,
      extension: extension ?? this.extension,
      year: setYearNull ? null : year ?? this.year,
      sectionId: sectionId ?? this.sectionId,
      materialId: materialId ?? this.materialId,
      categoriesIds: categoriesIds ?? this.categoriesIds,
      teacherId: setTeacherNull ? null : teacherId ?? this.teacherId,
      schoolId: setSchoolNull ? null : schoolId ?? this.schoolId,
    );
  }

  factory BacFile.empty() {
    return BacFile(
      id: "${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
      title: '',
      size: '',
      extension: '',
      categoriesIds: List.empty(growable: true),
    );
  }

  factory BacFile.fromPath({required String path}) {
    ///
    String title = normalizeFileName(path.split("/").last.split(".").first);

    ///
    List<String> categoriesIds = List.empty(growable: true);
    for (var word in title.split(" ")) {
      final response = extractRelevantElement<FileCategory>(word, sl<FileManagers>().categories, (e) => e.name)?.id;
      if (response != null) {
        categoriesIds.add(response);
      }
    }

    ///
    return BacFile(
      id: "${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
      title: title,
      size: File(path).lengthSync().toString(),
      extension: path.split("/").last.split(".").last,
      year: extractRelevantElement<int>(title, List.generate(10, (i) => 2024 - i), (e) => e.toString())?.toString(),
      materialId: extractRelevantElement<FileMaterial>(title, sl<FileManagers>().materials, (e) => e.name)?.id,
      sectionId: extractRelevantElement<FileSection>(title, sl<FileManagers>().sections, (e) => e.name)?.id,
      teacherId: extractRelevantElement<FileTeacher>(title, sl<FileManagers>().teachers, (e) => e.name)?.id,
      schoolId: extractRelevantElement<FileSchool>(title, sl<FileManagers>().schools, (e) => e.name)?.id,
      categoriesIds: categoriesIds,
    );
  }

  @override
  List<Object?> get props => [id, title, size, extension, year, sectionId, materialId, teacherId, schoolId];
}
