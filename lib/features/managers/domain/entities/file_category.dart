import 'package:equatable/equatable.dart';

class FileCategory extends Equatable {
  final String id;
  final String name;

  const FileCategory({
    this.id = '0',
    required this.name,
  });

  FileCategory copyWith({String? id, String? name}) {
    return FileCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }




  @override
  List<Object?> get props => [id, name];
}
