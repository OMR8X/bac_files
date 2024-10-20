import '../../domain/entities/file_section.dart';

class FileSectionModel extends FileSection {
  const FileSectionModel({
    required super.id,
    required super.name,
  });

  //
  factory FileSectionModel.fromJson(Map<String, dynamic> json) {
    return FileSectionModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }

  //
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
