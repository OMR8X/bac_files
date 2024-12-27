import 'package:bac_files/features/files/data/mappers/bac_file_mapper.dart';
import 'package:bac_files/features/files/data/models/bac_file_model.dart';
import 'package:bac_files/features/files/domain/entities/bac_file.dart';

import 'managers_base_converter.dart';

class BacFileConverter extends ManagersBaseConverter<BacFile> {
  @override
  BacFile fromJson(Map<String, dynamic> json) {
    return BacFileModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BacFile entity) {
    return entity.toModel.toJson();
  }
}
