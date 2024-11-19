import 'dart:math';

import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../home/state/bloc/home_bloc.dart';

part 'update_operation_file_event.dart';
part 'update_operation_file_state.dart';

class UpdateOperationFileBloc extends Bloc<UpdateOperationFileEvent, UpdateOperationFileState> {
  final UpdateOperationUseCase _updateOperationUseCase;
  final GetAllOperationsUseCase _getOperationsUseCase;
  UpdateOperationFileBloc(this._updateOperationUseCase, this._getOperationsUseCase) : super(UpdateOperationFileState.initial()) {
    on<UpdateOperationFileInitializeEvent>(onUpdateOperationFileInitializeEvent);
    on<UpdateOperationFileEditEvent>(onUpdateOperationFileEditEvent);
    on<UpdateOperationFileSaveEvent>(onUpdateOperationFileSaveEvent);
  }

  onUpdateOperationFileInitializeEvent(UpdateOperationFileInitializeEvent event, Emitter<UpdateOperationFileState> emit) async {
    //
    emit(state.copyWith(status: UpdateOperationFileStatus.fetching));
    //
    final response = await _getOperationsUseCase();
    //
    response.fold(
      (l) {
        emit(state.copyWith(failure: l, status: UpdateOperationFileStatus.failure));
      },
      (operations) {
        //
        if (!operations.map((e) => e.id).contains(event.operationId)) {
          emit(state.copyWith(failure: const FileNotExistsFailure(), status: UpdateOperationFileStatus.failure));
          return;
        }
        //
        final operation = operations.firstWhere((e) => e.id == event.operationId);
        //
        emit(state.copyWith(
          bacFile: operation.file,
          operation: operation,
          status: UpdateOperationFileStatus.initial,
        ));
      },
    );
  }

  onUpdateOperationFileEditEvent(UpdateOperationFileEditEvent event, Emitter<UpdateOperationFileState> emit) {
    emit(state.copyWith(bacFile: event.bacFile));
  }

  onUpdateOperationFileSaveEvent(UpdateOperationFileSaveEvent event, Emitter<UpdateOperationFileState> emit) async {
    //
    emit(state.copyWith(status: UpdateOperationFileStatus.loading));
    //
    final response = await _updateOperationUseCase(
        operation: state.operation.copyWith(
      file: state.bacFile,
      state: OperationState.initializing,
    ));
    //
    response.fold(
      (l) {
        emit(state.copyWith(status: UpdateOperationFileStatus.failure, failure: l));
      },
      (r) {
        sl<UploadsBloc>().add(const InitializeOperationsEvent());
        emit(state.copyWith(status: UpdateOperationFileStatus.success));
      },
    );
  }
}
