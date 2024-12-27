import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files/features/managers/domain/requests/delete_entity_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_file_event.dart';
part 'delete_file_state.dart';

class DeleteFileBloc extends Bloc<DeleteFileEvent, DeleteFileState> {
  final DeleteFileUsecase _deleteFileUsecase;
  DeleteFileBloc(this._deleteFileUsecase) : super(DeleteFileState.initial()) {
    on<DeleteFileEvent>(onDeleteFileEvent);
  }
  onDeleteFileEvent(DeleteFileEvent event, Emitter<DeleteFileState> emit) async {
    //
    emit(state.copyWith(status: DeleteFileStatus.loading));
    //
    final response = await _deleteFileUsecase(request: DeleteEntityRequest(id: event.fileId));
    //
    response.fold(
      (failure) {
        emit(state.copyWith(status: DeleteFileStatus.failure, failure: failure));
      },
      (success) {
        emit(state.copyWith(status: DeleteFileStatus.success));
      },
    );
  }
}
