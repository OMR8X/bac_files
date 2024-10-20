import '../../domain/entities/bac_file.dart';
import '../models/bac_file_model.dart';

extension BacFileMapper on BacFile {
  BacFileModel get toModel {
    return BacFileModel(
      id: id,
      title: title,
      size: size,
      extension: extension,
      year: year,
      sectionId: sectionId,
      materialId: materialId,
      teacherId: teacherId,
      schoolId: schoolId,
      categoriesIds: categoriesIds,
    );
  }
}

extension BacFileModelMapper on BacFileModel {
  BacFile get toEntity {
    return BacFile(
      id: id,
      title: title,
      size: size,
      extension: extension,
      year: year,
      sectionId: sectionId,
      materialId: materialId,
      teacherId: teacherId,
      schoolId: schoolId,
      categoriesIds: categoriesIds,
    );
  }
}
