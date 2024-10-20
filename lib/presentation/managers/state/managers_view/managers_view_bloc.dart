import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/delete_teacher_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../features/managers/data/responses/delete_entity_response.dart';
import '../../../../features/managers/domain/usecases/select_managers_usecase.dart';

part 'managers_view_event.dart';
part 'managers_view_state.dart';

class ManagersViewBloc extends Bloc<ManagersViewEvent, ManagersViewState> {
  final SelectManagersUseCase _selectManagersUseCase;
  ManagersViewBloc(this._selectManagersUseCase) : super(ManagersViewState.loading()) {
    on<ManagersViewInitializeEvent>(onManagersViewInitializeEvent);
    on<ManagersViewUpdateEvent>(onManagersViewUpdateEvent);
    on<ManagersViewDeleteItemEvent>(onManagersViewDeleteItemEvent);
  }

  ///
  onManagersViewInitializeEvent(ManagersViewInitializeEvent event, Emitter<ManagersViewState> emit) async {
    await _selectManagersUseCase().then((value) {
      value.fold(
        (failure) {
          emit(ManagersViewState.failure(failure: failure));
        },
        (success) {
          _injectManagers(success.entities.first);
          emit(ManagersViewState.initial(managers: success.entities.first));
        },
      );
    });
  }

  ///
  onManagersViewUpdateEvent(ManagersViewUpdateEvent event, Emitter<ManagersViewState> emit) async {
    ///
    ManagersViewState.loading();

    ///
    await _selectManagersUseCase().then((value) {
      value.fold(
        (failure) {
          emit(ManagersViewState.failure(failure: failure));
        },
        (success) {
          _injectManagers(success.entities.first);
          emit(ManagersViewState.initial(managers: success.entities.first));
        },
      );
    });
  }

  ///
  onManagersViewDeleteItemEvent(ManagersViewDeleteItemEvent event, Emitter<ManagersViewState> emit) async {
    //
    ManagersViewState.loading();
    //
    final response = await event.usecase;
    //
    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (success) {
        Fluttertoast.showToast(msg: success.message);
      },
    );
    //
    sl<ManagersViewBloc>().add(const ManagersViewUpdateEvent());
  }

  void _injectManagers(FileManagers managers) {
    //
    if (sl.isRegistered<FileManagers>()) {
      sl.unregister<FileManagers>();
    }
    //
    sl.registerSingleton<FileManagers>(managers);

    return;
  }
}
