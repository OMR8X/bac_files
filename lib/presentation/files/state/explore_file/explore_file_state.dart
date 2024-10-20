part of 'explore_file_bloc.dart';

enum ExploreFileStatus {
  fetching,
  loaded,
  failed,
}

final class ExploreFileState extends Equatable {
  const ExploreFileState({
    required this.file,
    required this.status,
    this.failure,
  });
  final BacFile file;
  final ExploreFileStatus status;
  final Failure? failure;

  factory ExploreFileState.fetching() {
    return ExploreFileState(file: BacFile.empty(), status: ExploreFileStatus.fetching, failure: null);
  }

  ExploreFileState loaded({required BacFile file}) {
    return ExploreFileState(
      file: file,
      status: ExploreFileStatus.loaded,
      failure: null,
    );
  }

  ExploreFileState failed({required Failure failure}) {
    return ExploreFileState(
      file: file,
      status: ExploreFileStatus.failed,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [file, status, failure];
}
