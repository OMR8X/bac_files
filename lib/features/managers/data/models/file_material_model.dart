import '../../domain/entities/file_material.dart';

class FileMaterialModel extends FileMaterial {
  const FileMaterialModel({
    required super.id,
    required super.name,
  });

  //
  factory FileMaterialModel.fromJson(Map<String, dynamic> json) {
    return FileMaterialModel(
      id: (json['id']).toString(),
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
