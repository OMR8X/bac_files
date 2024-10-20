import 'dart:async';

import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/select_managers_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_loader_event.dart';
part 'app_loader_state.dart';

class AppLoaderBloc extends Bloc<AppLoaderLoadData, AppLoaderState> {
  final SelectManagersUseCase _selectManagersUseCase;
  AppLoaderBloc(this._selectManagersUseCase) : super(AppLoaderState.loading()) {
    on<AppLoaderLoadData>(onAppLoaderLoadData);
  }

  onAppLoaderLoadData(AppLoaderLoadData event, Emitter<AppLoaderState> emit) async {
    await _selectManagersUseCase().then((value) {
      value.fold(
        (failure) {
          emit(AppLoaderState.failure(failure: failure));
        },
        (success) {
          _injectManagers(success.entities.first);
          emit(AppLoaderState.succeed());
        },
      );
    });
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
