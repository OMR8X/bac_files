import 'package:equatable/equatable.dart';

class FileTeacher extends Equatable {
  final String id;
  final String name;

  const FileTeacher({
    this.id = '0',
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
