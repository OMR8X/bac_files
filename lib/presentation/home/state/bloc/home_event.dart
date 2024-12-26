part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeLoadFilesEvent extends HomeEvent {
  final String? keywords;
  final List<String>? categories;
  const HomeLoadFilesEvent({this.keywords, this.categories});
  @override
  List<Object> get props => [];
}

final class HomeLoadMoreFilesEvent extends HomeEvent {
  const HomeLoadMoreFilesEvent();
  @override
  List<Object> get props => [];
}

final class DeleteFileEvent extends HomeEvent {
  final String fileId;
  const DeleteFileEvent({required this.fileId});
  @override
  List<Object> get props => [];
}
