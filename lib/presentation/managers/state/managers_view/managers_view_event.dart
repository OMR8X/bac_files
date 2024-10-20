part of 'managers_view_bloc.dart';

sealed class ManagersViewEvent extends Equatable {
  const ManagersViewEvent();

  @override
  List<Object> get props => [];
}

final class ManagersViewInitializeEvent extends ManagersViewEvent {
  const ManagersViewInitializeEvent();

  @override
  List<Object> get props => [];
}

final class ManagersViewUpdateEvent extends ManagersViewEvent {
  const ManagersViewUpdateEvent();

  @override
  List<Object> get props => [];
}

final class ManagersViewDeleteItemEvent<T> extends ManagersViewEvent {
  //
  final Future<Either<Failure, DeleteEntityResponse>> usecase;
  //
  const ManagersViewDeleteItemEvent({
    required this.usecase,
  });
  @override
  List<Object> get props => [];
}
