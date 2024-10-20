import 'package:equatable/equatable.dart';

class FileMaterial extends Equatable {
  final String id;
  final String name;

  const FileMaterial({
    this.id = '',
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
