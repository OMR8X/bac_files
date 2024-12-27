import 'package:bac_files/features/managers/data/mappers/school_mappers.dart';
import '../../domain/entities/school.dart';
import '../models/file_school_model.dart';
import 'managers_base_converter.dart';

class FileSchoolConverter extends ManagersBaseConverter<FileSchool> {
  @override
  FileSchool fromJson(Map<String, dynamic> json) {
    return FileSchoolModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FileSchool entity) {
    return entity.toModel.toJson();
  }
}
