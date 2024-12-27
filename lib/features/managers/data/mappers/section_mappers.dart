import 'package:bac_files/features/managers/data/models/file_section_model.dart';
import 'package:bac_files/features/managers/domain/entities/file_section.dart';

extension SectionMapper on FileSection {
  FileSectionModel get toModel {
    return FileSectionModel(
      id: id,
      name: name,
    );
  }
}

extension FileSectionModelMapper on FileSectionModel {
  FileSection get toEntity {
    return FileSection(
      id: id,
      name: name,
    );
  }
}
