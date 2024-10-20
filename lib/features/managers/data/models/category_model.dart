import '../../domain/entities/file_category.dart';

class FileCategoryModel extends FileCategory {
  const FileCategoryModel({
    required super.id,
    required super.name,
  });

  //
  factory FileCategoryModel.fromJson(Map<String, dynamic> json) {
    return FileCategoryModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }

  //
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
