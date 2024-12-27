import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:bac_files/features/managers/domain/usecases/select_managers_usecase.dart';
import 'package:flutter/material.dart';
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
    //
    await _selectManagersUseCase().then((value) {
      value.fold(
        (failure) {
          if (failure is AuthFailure) {
            emit(AppLoaderState.failure(failure: failure, state: LoadState.unauthenticated));
          } else {
            emit(AppLoaderState.failure(failure: failure, state: LoadState.failure));
          }
        },
        (success) {
          if (success.entities.isNotEmpty) {
            _injectManagers(success.entities.first);
          }
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
