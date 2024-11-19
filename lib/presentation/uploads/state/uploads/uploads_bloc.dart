import 'dart:async';
import 'dart:math';

import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/uploads/data/models/upload_operation_model.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/add_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/delete_all_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/delete_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/presentation/home/state/bloc/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/uploads/domain/entities/upload_operation.dart';
import '../../../../features/uploads/domain/usecases/operations/add_operations_usecase.dart';

part 'uploads_event.dart';
part 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  ///
  late StreamSubscription _backgroundUpdateStateSubscription;

  ///
  final GetAllOperationsUseCase _getOperationsUseCase;
  final AddOperationUseCase _addOperationUseCase;
  final AddOperationsUseCase _addOperationsUseCase;
  final DeleteOperationUseCase _deleteOperationUseCase;
  final DeleteAllOperationUseCase _deleteAllOperationUseCase;

  ///
  UploadsBloc(
    this._getOperationsUseCase,
    this._addOperationUseCase,
    this._deleteOperationUseCase,
    this._addOperationsUseCase,
    this._deleteAllOperationUseCase,
  ) : super(UploadsState.initializing()) {
    ///
    on<InitializeOperationsEvent>(onInitializeOperationsEvent);
    on<UpdateOperationsEvent>(onUpdateOperationsEvent);
    //
    on<AddOperationEvent>(onAddOperationEvent);
    on<AddSharedOperationEvent>(onAddSharedOperationEvent);
    on<CompleteOperationEvent>(onCompleteOperationEvent);
    on<FailedOperationEvent>(onFailedOperationEvent);
    //
    on<StartOperationEvent>(onStartOperationEvent);
    on<StartAllOperationsEvent>(onStartAllOperationsEvent);
    on<DeleteAllOperationsEvent>(onDeleteAllOperationsEvent);
    on<StopOperationEvent>(onStopOperationEvent);
    on<StopAllOperationEvent>(onStopAllOperationEvent);
    on<RefreshOperationEvent>(onRefreshOperationEvent);
    on<DeleteOperationEvent>(onDeleteOperationEvent);
    //
  }

  ///
  onInitializeOperationsEvent(InitializeOperationsEvent event, Emitter<UploadsState> emit) async {
    //
    await emitContent(emit: emit);
    //
    await refreshUploads();
    //
    _backgroundUpdateStateSubscription = FlutterBackgroundService().on("on-update-state").listen((event) {
      //
      sl<DebuggingManager>()().logMessage("receiving update state from background service");
      //
      if (event?["operations"] != null) {
        //
        List<UploadOperation> operations = (event!["operations"] as List).map((e) {
          return UploadOperationModel.fromJson(e);
        }).toList();
        //
        sl<UploadsBloc>().add(UpdateOperationsEvent(operations: operations));
      } else {
        sl<UploadsBloc>().add(const UpdateOperationsEvent());
      }
      //
    });
  }

  onUpdateOperationsEvent(UpdateOperationsEvent event, Emitter<UploadsState> emit) async {
    await emitContent(emit: emit, operations: event.operations);
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
    sl<HomeBloc>().add(const HomeLoadFilesEvent());
    await emitContent(emit: emit);
  }

  onFailedOperationEvent(FailedOperationEvent event, Emitter<UploadsState> emit) async {
    await emitContent(emit: emit);
  }

  onAddSharedOperationEvent(AddSharedOperationEvent event, Emitter<UploadsState> emit) async {
    //
    List<UploadOperation> operations = [];
    //
    for (var path in event.paths) {
      operations.add(UploadOperation(
        id: 0,
        path: path,
        file: BacFile.fromPath(path: path),
        state: OperationState.created,
      ));
    }
    await _addOperationsUseCase.call(operations: operations);
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
    await _deleteOperationUseCase.call(operationId: event.operation.id);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onDeleteAllOperationsEvent(DeleteAllOperationsEvent event, Emitter<UploadsState> emit) async {
    //
    await _deleteAllOperationUseCase.call();
    //
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

  Future<void> emitContent({required Emitter<UploadsState> emit, List<UploadOperation>? operations}) async {
    ///
    if (operations != null) {
      emit(UploadsState.content(operations: List.from(operations)));
      return;
    }

    ///
    final operationsResponse = await _getOperationsUseCase();

    ///
    operationsResponse.fold(
      (l) {
        debugPrint(l.toString());
        emit(UploadsState.failure(failure: l));
      },
      (r) => emit(UploadsState.content(operations: List.from(r))),
    );

    ///
    return;
  }

  @override
  Future<void> close() {
    _backgroundUpdateStateSubscription.cancel();
    return super.close();
  }
}
