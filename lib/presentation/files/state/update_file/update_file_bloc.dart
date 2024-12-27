import 'package:bac_files/features/files/domain/usecases/get_file_usecase.dart';
import 'package:bac_files/features/files/domain/usecases/update_file_usecase.dart';
import 'package:bac_files/features/managers/domain/requests/select_entity_request.dart';
import 'package:bac_files/features/managers/domain/requests/update_entity_request.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../features/files/domain/entities/bac_file.dart';
import '../../../home/state/bloc/home_bloc.dart';

part 'update_file_event.dart';
part 'update_file_state.dart';

class UpdateFileBloc extends Bloc<UpdateFileEvent, UpdateFileState> {
  final GetFileUsecase _getFileUsecase;
  final UpdateFileUsecase _updateFileUsecase;
  UpdateFileBloc(this._getFileUsecase, this._updateFileUsecase) : super(UpdateFileState.initial()) {
    on<UpdateFileInitializeEvent>(_onUpdateFileInitializeEvent);
    on<UpdateFileEditEvent>(_onUpdateFileEditEvent);
    on<UpdateFileUploadEvent>(_onUpdateFileUploadEvent);
  }
  //
  _onUpdateFileInitializeEvent(UpdateFileInitializeEvent event, Emitter<UpdateFileState> emit) async {
    //
    emit(state.copyWith(status: UpdateFileStatus.fetching));
    //
    final response = await _getFileUsecase(request: SelectEntityRequest(id: event.fileId));
    //
    response.fold(
      (l) {
        emit(state.copyWith(failure: l, status: UpdateFileStatus.failure));
      },
      (r) {
        emit(state.copyWith(bacFile: r.entity, status: UpdateFileStatus.initial));
      },
    );
  }

  //
  _onUpdateFileEditEvent(UpdateFileEditEvent event, Emitter<UpdateFileState> emit) async {
    emit(state.copyWith(bacFile: event.bacFile));
  }

  //
  _onUpdateFileUploadEvent(UpdateFileUploadEvent event, Emitter<UpdateFileState> emit) async {
    //
    emit(state.copyWith(status: UpdateFileStatus.loading));
    //
    final response = await _updateFileUsecase(
      request: UpdateEntityRequest<BacFile>(id: state.bacFile.id, entity: state.bacFile),
    );
    //
    response.fold(
      (l) {
        emit(state.copyWith(status: UpdateFileStatus.failure, failure: l));
      },
      (r) {
        sl<HomeBloc>().add(const HomeLoadFilesEvent());
        emit(state.copyWith(status: UpdateFileStatus.success));
      },
    );
  }
}
