part of 'explore_file_bloc.dart';

final class ExploreFileEvent extends Equatable {
  const ExploreFileEvent();

  @override
  List<Object> get props => [];
}

final class ExploreFileInitializeEvent extends ExploreFileEvent {
  const ExploreFileInitializeEvent({required this.fileId});
  final String fileId;
  @override
  List<Object> get props => [];
}
