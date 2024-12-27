import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/files/domain/entities/bac_file.dart';
import 'package:bac_files/features/files/domain/usecases/get_file_usecase.dart';
import 'package:bac_files/features/managers/domain/requests/select_entity_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_file_event.dart';
part 'explore_file_state.dart';

class ExploreFileBloc extends Bloc<ExploreFileEvent, ExploreFileState> {
  final GetFileUsecase _getFileUsecase;
  ExploreFileBloc(this._getFileUsecase) : super(ExploreFileState.fetching()) {
    on<ExploreFileInitializeEvent>(onExploreFileInitializeEvent);
  }

  onExploreFileInitializeEvent(ExploreFileInitializeEvent event, Emitter<ExploreFileState> emit) async {
    //
    await _getFileUsecase.call(request: SelectEntityRequest(id: event.fileId)).then((response) {
      return response.fold(
        (l) async {
          return emit(state.failed(failure: l));
        },
        (r) async {
          return emit(state.loaded(file: r.entity));
        },
      );
    });
    //
  }
}
