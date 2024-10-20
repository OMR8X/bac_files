part of 'managers_view_bloc.dart';

final class ManagersViewState extends Equatable {
  final bool isLoading;
  final Failure? failure;
  final FileManagers managers;

  const ManagersViewState({
    required this.isLoading,
    required this.failure,
    required this.managers,
  });

  factory ManagersViewState.loading() {
    return ManagersViewState(
      isLoading: true,
      failure: null,
      managers: FileManagers.empty(),
    );
  }
  factory ManagersViewState.failure({required Failure? failure}) {
    return ManagersViewState(
      isLoading: false,
      failure: failure,
      managers: FileManagers.empty(),
    );
  }
  factory ManagersViewState.initial({required FileManagers managers}) {
    return ManagersViewState(
      isLoading: false,
      failure: null,
      managers: managers,
    );
  }
  @override
  List<Object?> get props => [isLoading, failure, managers];
}
