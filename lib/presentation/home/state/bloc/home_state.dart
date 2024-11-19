part of 'home_bloc.dart';

enum HomeStatus { initial, loading, fetchingMoreData, failure }

final class HomeState extends Equatable {
  const HomeState({
    this.lastPage,
    this.currentPage = 1,
    required this.keywords,
    required this.status,
    required this.failure,
    required this.files,
  });
  final int? lastPage;
  final int currentPage;
  final String? keywords;
  final HomeStatus status;
  final Failure? failure;
  final List<BacFile> files;

  factory HomeState.loading() {
    return const HomeState(
      keywords: null,
      status: HomeStatus.loading,
      failure: null,
      files: [],
    );
  }
  HomeState copyWith({
    int? lastPage,
    int? currentPage,
    String? keywords,
    HomeStatus? status,
    Failure? failure,
    List<BacFile>? files,
  }) {
    return HomeState(
      lastPage: lastPage ?? this.lastPage,
      currentPage: currentPage ?? this.currentPage,
      keywords: keywords ?? this.keywords,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [status, failure, files, files.length, currentPage, lastPage, keywords];
}
