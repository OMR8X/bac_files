import 'package:equatable/equatable.dart';

class FileSchool extends Equatable {
  final String id;
  final String name;

  const FileSchool({
    this.id = '0',
    required this.name,
  });
  @override
  List<Object?> get props => [id, name];
}
