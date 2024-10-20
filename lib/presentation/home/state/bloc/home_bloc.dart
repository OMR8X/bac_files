import 'dart:math';

import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/get_all_files_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entities_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/injector/app_injection.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllFilesUsecase _getAllFilesUsecase;
  final DeleteFileUsecase _deleteFileUsecase;
  HomeBloc(this._getAllFilesUsecase, this._deleteFileUsecase) : super(HomeState.loading()) {
    on<HomeLoadFilesEvent>(onHomeLoadFilesEvent);
    on<DeleteFileEvent>(onDeleteFileEvent);
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
        emit(state.copyWith(status: HomeStatus.initial, files: r.entities, keywords: event.keywords));
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
