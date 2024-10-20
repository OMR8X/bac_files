import '../../domain/entities/school.dart';

class FileSchoolModel extends FileSchool {
  const FileSchoolModel({
    required super.id,
    required super.name,
  });

  //
  factory FileSchoolModel.fromJson(Map<String, dynamic> json) {
    return FileSchoolModel(
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
