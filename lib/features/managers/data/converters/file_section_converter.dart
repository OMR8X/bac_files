import 'package:bac_files_admin/features/managers/data/mappers/section_mappers.dart';
import '../../domain/entities/file_section.dart';
import '../models/file_section_model.dart';
import 'managers_base_converter.dart';

class FileSectionConverter extends ManagersBaseConverter<FileSection> {
  @override
  FileSection fromJson(Map<String, dynamic> json) {
    return FileSectionModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FileSection entity) {
    return entity.toModel.toJson();
  }
}
