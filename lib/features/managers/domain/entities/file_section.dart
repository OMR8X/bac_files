import 'package:equatable/equatable.dart';


class FileSection extends Equatable {
  final String id;
  final String name;

  const FileSection({
    this.id = '',
    required this.name,
  });

 

  @override
  List<Object?> get props => [id, name];
}
