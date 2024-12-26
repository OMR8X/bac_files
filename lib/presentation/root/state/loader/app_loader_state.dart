part of 'app_loader_bloc.dart';

enum LoadState {
  failure,
  loading,
  unauthenticated,
  succeed,
}

final class AppLoaderState extends Equatable {
  //
  final LoadState state;
  final Failure? failure;
  //
  const AppLoaderState({required this.state, required this.failure});
  //
  factory AppLoaderState.loading() {
    return const AppLoaderState(
      state: LoadState.loading,
      failure: null,
    );
  }
  //
  factory AppLoaderState.failure({required Failure failure, LoadState? state}) {
    return AppLoaderState(
      state: state ?? LoadState.failure,
      failure: failure,
    );
  }
  //
  factory AppLoaderState.succeed() {
    return const AppLoaderState(
      state: LoadState.succeed,
      failure: null,
    );
  }
  @override
  List<Object?> get props => [state, failure];
}
