import 'package:bac_files/features/managers/data/models/file_school_model.dart';
import 'package:bac_files/features/managers/domain/entities/school.dart';

extension SchoolMapper on FileSchool {
  FileSchoolModel get toModel {
    return FileSchoolModel(
      id: id,
      name: name,
    );
  }
}

extension SchoolModelMapper on FileSchoolModel {
  FileSchool get toEntity {
    return FileSchool(
      id: id,
      name: name,
    );
  }
}
