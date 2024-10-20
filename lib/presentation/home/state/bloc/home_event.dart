part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeLoadFilesEvent extends HomeEvent {
  final String? keywords;
  const HomeLoadFilesEvent({this.keywords});
  @override
  List<Object> get props => [];
}

final class DeleteFileEvent extends HomeEvent {
  final String fileId;
  const DeleteFileEvent({required this.fileId});
  @override
  List<Object> get props => [];
}
