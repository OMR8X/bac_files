import 'dart:math';

import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/get_all_files_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entities_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../features/managers/data/responses/select_entities_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllFilesUsecase _getAllFilesUsecase;
  final DeleteFileUsecase _deleteFileUsecase;
  HomeBloc(this._getAllFilesUsecase, this._deleteFileUsecase) : super(HomeState.loading()) {
    on<HomeLoadFilesEvent>(onHomeLoadFilesEvent);
    on<DeleteFileEvent>(onDeleteFileEvent);
    on<HomeLoadMoreFilesEvent>(onHomeLoadMoreFilesEvent);
  }
  onHomeLoadFilesEvent(HomeLoadFilesEvent event, Emitter<HomeState> emit) async {
    //
    emit(HomeState.loading());
    //
    final response = await _getAllFilesUsecase(
      request: SelectEntitiesRequest(
        queryParameters: (state.keywords?.isNotEmpty ?? event.keywords?.isNotEmpty ?? false) ? {'keywords': event.keywords} : {},
      ),
    );
    //
    response.fold(
      (l) {
        emit(state.copyWith(status: HomeStatus.failure, failure: l));
      },
      (r) {
        emit(state.copyWith(
          status: HomeStatus.initial,
          files: r.entities,
          keywords: event.keywords,
          lastPage: r.lastPage,
        ));
      },
    );
  }

  onHomeLoadMoreFilesEvent(HomeLoadMoreFilesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.fetchingMoreData));
    //
    debugPrint("here, currentPage : ${state.currentPage}, lastPage : ${state.lastPage}");
    //
    int currentPage = state.currentPage + 1;
    int lastPage = state.lastPage ?? 0;
    //
    if (currentPage > lastPage) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: HomeStatus.initial));
      return;
    }
    //
    emit(state.copyWith(status: HomeStatus.fetchingMoreData));
    //
    Map<String, dynamic> queryParameters = {
      "page": currentPage,
      "keywords": state.keywords,
    };
    //
    final response = await _getAllFilesUsecase(
      request: SelectEntitiesRequest(
        queryParameters: queryParameters,
      ),
    );
    //
    response.fold(
      (l) {
        emit(state.copyWith(status: HomeStatus.failure, failure: l));
      },
      (r) {
        emit(state.copyWith(
          currentPage: currentPage,
          status: HomeStatus.initial,
          files: state.files + r.entities,
          keywords: state.keywords,
        ));
      },
    );
  }

  onDeleteFileEvent(DeleteFileEvent event, Emitter<HomeState> emit) async {
    //
    emit(state.copyWith(status: HomeStatus.loading));
    //
    final response = await _deleteFileUsecase(request: DeleteEntityRequest(id: event.fileId));
    //
    response.fold(
      (l) {
        emit(state.copyWith(status: HomeStatus.failure, failure: l));
      },
      (r) {
        sl<HomeBloc>().add(HomeLoadFilesEvent(keywords: state.keywords));
      },
    );
  }
}
