import 'dart:math';

import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/core/services/router/index.dart';
import 'package:bac_files/features/auth/domain/requests/sign_out_request.dart';
import 'package:bac_files/features/auth/domain/requests/update_user_data_request.dart';
import 'package:bac_files/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:bac_files/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:bac_files/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:bac_files/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bac_files/features/auth/domain/usecases/update_user_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../core/services/router/app_routes.dart';
import '../../../../features/auth/domain/entites/user_data.dart';
import '../../../../features/auth/domain/requests/get_user_data_request.dart';
import '../../../../features/auth/domain/requests/sign_in_request.dart';
import '../../../../features/auth/domain/requests/sign_up_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final UpdateUserDataUseCase _updateUserDataUseCase;

  AuthBloc(this._getUserDataUseCase, this._signInUseCase, this._signUpUseCase, this._signOutUseCase, this._updateUserDataUseCase) : super(const AuthLoadingState()) {
    //
    on<AuthInitializeEvent>(onAuthInitializeEvent);
    //
    on<AuthStartAuthEvent>((event, emit) => emit(const AuthStartState()));
    on<AuthStartSignInEvent>((event, emit) => emit(const AuthSigningInState()));
    on<AuthStartSignUpEvent>((event, emit) => emit(const AuthSigningUpState()));
    //
    on<AuthSignInEvent>(onAuthSignInEvent);
    on<AuthSignUpEvent>(onAuthSignUpEvent);
    on<AuthSignOutEvent>(onAuthSignOutEvent);
    on<AuthUpdateUserDataEvent>(onAuthUpdateUserDataEvent);
    //
  }
  //
  onAuthInitializeEvent(AuthInitializeEvent event, Emitter<AuthState> emit) async {
    //
    emit(const AuthLoadingState());
    //
    final response = await _getUserDataUseCase(request: GetUserDataRequest());
    //
    response.fold(
      (failure) {
        emit(AuthStartState(failure: failure));
      },
      (r) {
        _injectUserData(r.user);
        emit(const AuthDoneState());
      },
    );
  }

  //
  onAuthSignInEvent(AuthSignInEvent event, Emitter<AuthState> emit) async {
    //
    final String email = event.email.trim();
    final String password = event.password.trim();
    //
    final signUpRequest = SignInRequest(
      email: email,
      password: password,
    );
    //
    emit(const AuthSigningInState(loading: true));
    //
    final response = await _signInUseCase(request: signUpRequest);
    //
    response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message);
        emit(AuthSigningInState(loading: false, failure: l));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthSigningInState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthSignUpEvent(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    //
    final String name = event.name.trim();
    final String email = event.email.trim();
    final String password = event.password.trim();
    //
    final signUpRequest = SignUpRequest(
      name: name,
      email: email,
      password: password,
    );
    //
    emit(const AuthSigningUpState(loading: true));
    //
    final response = await _signUpUseCase(request: signUpRequest);
    //
    response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message);
        emit(AuthSigningUpState(loading: false, failure: l));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthSigningUpState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  //
  onAuthUpdateUserDataEvent(AuthUpdateUserDataEvent event, Emitter<AuthState> emit) async {
    //
    final String? name = event.name?.trim();
    final String? email = event.email?.trim();
    final String? password = event.password?.trim();
    //
    final updateUserDataRequest = UpdateUserDataRequest(
      name: name,
      email: email,
      password: password,
    );
    //
    final response = await _updateUserDataUseCase(request: updateUserDataRequest);
    //
    response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message);
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        _injectUserData(r.user);
        AppRouter.router.pop();
      },
    );
    //
  }

  //
  onAuthSignOutEvent(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    //
    AppRouter.router.pushReplacement(AppRoutes.authViewsManager.path);

    //
    emit(const AuthLoadingState());
    //
    final response = await _signOutUseCase(request: SignOutRequest());
    //
    response.fold(
      (l) {
        Fluttertoast.showToast(msg: l.message);
        emit(AuthStartState(loading: false, failure: l));
      },
      (r) {
        Fluttertoast.showToast(msg: r.message);
        emit(const AuthStartState(loading: false, failure: null));
        sl<AuthBloc>().add(const AuthInitializeEvent());
      },
    );
    //
  }

  void _injectUserData(UserData data) {
    //
    if (sl.isRegistered<UserData>()) {
      sl.unregister<UserData>();
    }
    //
    sl.registerSingleton<UserData>(data);

    return;
  }
}
