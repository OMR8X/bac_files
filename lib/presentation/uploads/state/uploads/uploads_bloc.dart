import 'dart:async';
import 'dart:math';

import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/add_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/delete_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/cache/cache_manager.dart';
import '../../../../features/uploads/domain/entities/upload_operation.dart';

part 'uploads_event.dart';
part 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  ///
  late final StreamSubscription _backgroundUpdateStateSubscription;

  ///
  final CacheManager _cacheManager;

  ///
  final GetAllOperationsUseCase _getOperationsUseCase;
  final AddOperationUseCase _addOperationUseCase;
  final DeleteOperationUseCase _deleteOperationUseCase;
  final UpdateOperationUseCase _updateOperationUseCase;

  ///
  UploadsBloc(
    this._getOperationsUseCase,
    this._addOperationUseCase,
    this._deleteOperationUseCase,
    this._updateOperationUseCase,
    this._cacheManager,
  ) : super(UploadsState.initializing()) {
    ///
    on<InitializeOperationsEvent>(onInitializeOperationsEvent);
    on<UpdateOperationsEvent>(onUpdateOperationsEvent);
    //
    on<AddOperationEvent>(onAddOperationEvent);
    on<AddSharedOperationEvent>(onAddSharedOperationEvent);
    on<CompleteOperationEvent>(onCompleteOperationEvent);
    //
    on<StartOperationEvent>(onStartOperationEvent);
    on<StartAllOperationsEvent>(onStartAllOperationsEvent);
    on<StopOperationEvent>(onStopOperationEvent);
    on<StopAllOperationEvent>(onStopAllOperationEvent);
    on<RefreshOperationEvent>(onRefreshOperationEvent);
    on<DeleteOperationEvent>(onDeleteOperationEvent);
    //
    on<FailedOperationEvent>((event, emit) {});
  }

  ///
  onInitializeOperationsEvent(InitializeOperationsEvent event, Emitter<UploadsState> emit) async {
    //
    await emitContent(emit);
    //
    await refreshUploads();
    //
    _backgroundUpdateStateSubscription = FlutterBackgroundService().on("on-update-state").listen((event) {
      //
      sl<DebuggingManager>()().logMessage("receiving update state from background service");
      //
      sl<UploadsBloc>().add(const UpdateOperationsEvent());
      //
    });
  }

  onUpdateOperationsEvent(UpdateOperationsEvent event, Emitter<UploadsState> emit) async {
    await emitContent(emit);
  }

  onAddOperationEvent(AddOperationEvent event, Emitter<UploadsState> emit) async {
    //
    emit(state.addOperation(event.operation));
    //
    await _addOperationUseCase.call(operation: event.operation);
    //
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onCompleteOperationEvent(CompleteOperationEvent event, Emitter<UploadsState> emit) async {
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onAddSharedOperationEvent(AddSharedOperationEvent event, Emitter<UploadsState> emit) async {
    //
    final operation = UploadOperation(
      id: 0,
      path: event.path,
      file: BacFile.fromPath(path: event.path),
      state: OperationState.initializing,
    );
    //
    emit(state.addOperation(operation));
    //
    await _addOperationUseCase.call(operation: operation);
    //
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onRefreshOperationEvent(RefreshOperationEvent event, Emitter<UploadsState> emit) async {
    refreshUploads();
  }

  ///
  onStartOperationEvent(StartOperationEvent event, Emitter<UploadsState> emit) {
    startUpload(event.operation.id);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStartAllOperationsEvent(StartAllOperationsEvent event, Emitter<UploadsState> emit) {
    startAllUploads();
  }

  ///
  onStopOperationEvent(StopOperationEvent event, Emitter<UploadsState> emit) {
    stopUpload(event.operation.id);
  }

  ///
  onStopAllOperationEvent(StopAllOperationEvent event, Emitter<UploadsState> emit) {
    stopAllUploads();
  }

  ///
  onDeleteOperationEvent(DeleteOperationEvent event, Emitter<UploadsState> emit) async {
    emit(state.removeOperation(event.operation.id));
    await _deleteOperationUseCase.call(operationId: event.operation.id);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  Future<void> startUpload(int operationID) async {
    sl<DebuggingManager>()().logDebug("calling start upload from bloc , operation id: $operationID");
    FlutterBackgroundService().invoke("start_upload", {
      "operation_id": operationID,
    });
  }

  Future<void> startAllUploads() async {
    sl<DebuggingManager>()().logMessage("calling start_all_uploads from bloc");
    FlutterBackgroundService().invoke("start_all_uploads");
  }

  Future<void> stopUpload(int operationID) async {
    sl<DebuggingManager>()().logDebug("calling stop_upload from bloc , operation id: $operationID");
    FlutterBackgroundService().invoke("stop_upload", {
      "operation_id": operationID,
    });
  }

  Future<void> stopAllUploads() async {
    sl<DebuggingManager>()().logMessage("1 - calling stop_all_uploads from bloc");
    FlutterBackgroundService().invoke("stop_all_uploads");
  }

  Future<void> refreshUploads() async {
    sl<DebuggingManager>()().logMessage("calling refresh_uploads from bloc");
    FlutterBackgroundService().invoke("refresh_uploads");
  }

  Future<void> emitContent(Emitter<UploadsState> emit) async {
    ///
    final operations = await _getOperationsUseCase();

    ///
    operations.fold(
      (l) {
        debugPrint(l.toString());
        emit(UploadsState.failure(failure: l));
      },
      (r) => emit(UploadsState.content(operations: List.from(r))),
    );

    ///
    return;
  }
}
