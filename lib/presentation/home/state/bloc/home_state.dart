part of 'home_bloc.dart';

enum HomeStatus { initial, loading, failure }

final class HomeState extends Equatable {
  const HomeState({
    required this.keywords,
    required this.status,
    required this.failure,
    required this.files,
  });
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
    String? keywords,
    HomeStatus? status,
    Failure? failure,
    List<BacFile>? files,
  }) {
    return HomeState(
      keywords: keywords ?? this.keywords,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [status, failure, files];
}
