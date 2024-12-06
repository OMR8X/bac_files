import 'dart:async';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:bac_files_admin/features/operations/domain/usecases/update_operation_usecase.dart';
import 'package:bac_files_admin/features/operations/domain/usecases/update_operations_usecase.dart';
import 'package:bac_files_admin/presentation/home/state/bloc/home_bloc.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../features/operations/domain/entities/operation.dart';
import '../../../../features/operations/domain/entities/operation_state.dart';
import '../../../../features/operations/domain/usecases/add_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/add_operations_usecase.dart';
import '../../../../features/operations/domain/usecases/delete_all_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/delete_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/get_operations_usecase.dart';

part 'uploads_event.dart';
part 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  ///
  late StreamSubscription _backgroundUpdateStateSubscription;
  late StreamSubscription _backgroundOnCompleteSubscription;
  late StreamSubscription _backgroundOnFailedSubscription;

  ///
  final GetAllOperationsUseCase _getOperationsUseCase;
  final AddOperationUseCase _addOperationUseCase;
  final AddOperationsUseCase _addOperationsUseCase;
  final DeleteOperationUseCase _deleteOperationUseCase;
  final DeleteAllOperationUseCase _deleteAllOperationUseCase;
  final UpdateOperationUseCase _updateOperationUseCase;
  final UpdateAllOperationsStateUseCase _updateAllOperationsStateUseCase;

  ///
  UploadsBloc(
    this._getOperationsUseCase,
    this._addOperationUseCase,
    this._deleteOperationUseCase,
    this._addOperationsUseCase,
    this._deleteAllOperationUseCase,
    this._updateOperationUseCase,
    this._updateAllOperationsStateUseCase,
  ) : super(UploadsState.initializing()) {
    ///
    on<InitializeUploadsEvent>(onInitializeOperationsEvent);
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
  onInitializeOperationsEvent(InitializeUploadsEvent event, Emitter<UploadsState> emit) async {
    //
    await emitContent(emit: emit);
    //
    _backgroundUpdateStateSubscription = FlutterBackgroundService().on("on-update-state").listen((event) {
      //
      sl<UploadsBloc>().add(const UpdateOperationsEvent());
      //
    });
    //
    _backgroundOnCompleteSubscription = FlutterBackgroundService().on("on-completed").listen((data) {
      //
      final operationId = data!['operation_id'] as int;
      final fileId = data['file_id'] as String;
      //
      if (state.operations.any((e) => e.file.id == fileId || e.id == operationId)) {
        sl<UploadsBloc>().add(const CompleteOperationEvent());
      }
      //
    });
    //
    _backgroundOnFailedSubscription = FlutterBackgroundService().on("on-failed").listen((data) {
      //
      final operationId = data!['operation_id'] as int;
      final fileId = data['file_id'] as String;
      //
      if (state.operations.any((e) => e.file.id == fileId || e.id == operationId)) {
        sl<UploadsBloc>().add(const FailedOperationEvent());
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
    await sl<CacheManager>().refresh();
    sl<HomeBloc>().add(const HomeLoadFilesEvent());
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onFailedOperationEvent(FailedOperationEvent event, Emitter<UploadsState> emit) async {
    await sl<CacheManager>().refresh();
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onAddSharedOperationEvent(AddSharedOperationEvent event, Emitter<UploadsState> emit) async {
    //
    List<Operation> operations = [];
    //
    for (var path in event.paths) {
      operations.add(Operation(
        id: 0,
        path: path,
        file: BacFile.fromPath(path: path),
        state: OperationState.created,
        type: OperationType.upload,
      ));
    }
    //
    await _addOperationsUseCase.call(operations: operations);
    //
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  onRefreshOperationEvent(RefreshOperationEvent event, Emitter<UploadsState> emit) async {
    emitContent(emit: emit);
  }

  ///
  onStartOperationEvent(StartOperationEvent event, Emitter<UploadsState> emit) async {
    //
    await _updateOperationUseCase(
        operation: event.operation.copyWith(
      state: OperationState.pending,
    ));
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStartAllOperationsEvent(StartAllOperationsEvent event, Emitter<UploadsState> emit) async {
    //
    await _updateAllOperationsStateUseCase(type: OperationType.upload, state: OperationState.pending);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStopOperationEvent(StopOperationEvent event, Emitter<UploadsState> emit) async {
    //
    await _updateOperationUseCase(
        operation: event.operation.copyWith(
      state: OperationState.initializing,
    ));
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStopAllOperationEvent(StopAllOperationEvent event, Emitter<UploadsState> emit) async {
    //
    await _updateAllOperationsStateUseCase(
      type: OperationType.upload,
      state: OperationState.initializing,
    );
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onDeleteOperationEvent(DeleteOperationEvent event, Emitter<UploadsState> emit) async {
    //
    await _deleteOperationUseCase(operationId: event.operation.id);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onDeleteAllOperationsEvent(DeleteAllOperationsEvent event, Emitter<UploadsState> emit) async {
    //
    await _deleteAllOperationUseCase(type: OperationType.upload);
    sl<UploadsBloc>().add(const UpdateOperationsEvent());
  }

  Future<void> invoker() async {
    FlutterBackgroundService().invoke("refresh_uploads");
  }

  Future<void> emitContent({required Emitter<UploadsState> emit, List<Operation>? operations}) async {
    ///
    if (operations != null) {
      emit(UploadsState.content(operations: List.from(operations)));
      return;
    }
//
    final operationsResponse = await _getOperationsUseCase(type: OperationType.upload);

    ///
    operationsResponse.fold(
      (l) {
        emit(UploadsState.failure(failure: l));
      },
      (r) {
        emit(UploadsState.content(operations: List.from(r)));
      },
    );

    ///
    return;
  }

  @override
  Future<void> close() {
    _backgroundUpdateStateSubscription.cancel();
    _backgroundOnCompleteSubscription.cancel();
    _backgroundOnFailedSubscription.cancel();
    return super.close();
  }
}
