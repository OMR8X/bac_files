part of 'delete_file_bloc.dart';

final class DeleteFileEvent extends Equatable {
  final String fileId;
  const DeleteFileEvent({required this.fileId});
  @override
  List<Object> get props => [];
}
