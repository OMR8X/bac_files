import '../../domain/entities/teacher.dart';

class FileTeacherModel extends FileTeacher {
  const FileTeacherModel({
    required super.id,
    required super.name,
  });

  //
  factory FileTeacherModel.fromJson(Map<String, dynamic> json) {
    return FileTeacherModel(
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
