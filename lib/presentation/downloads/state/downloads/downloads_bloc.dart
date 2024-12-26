import 'dart:async';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/paths/app_paths.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../../../features/operations/domain/entities/operation.dart';
import '../../../../features/operations/domain/entities/operation_state.dart';
import '../../../../features/operations/domain/usecases/add_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/add_operations_usecase.dart';
import '../../../../features/operations/domain/usecases/delete_all_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/delete_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/get_operations_usecase.dart';
import '../../../../features/operations/domain/usecases/update_operation_usecase.dart';
import '../../../../features/operations/domain/usecases/update_operations_usecase.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
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
  DownloadsBloc(
    this._getOperationsUseCase,
    this._addOperationUseCase,
    this._deleteOperationUseCase,
    this._addOperationsUseCase,
    this._deleteAllOperationUseCase,
    this._updateOperationUseCase,
    this._updateAllOperationsStateUseCase,
  ) : super(DownloadsState.initializing()) {
    ///
    on<InitializeDownloadsEvent>(onInitializeOperationsEvent);
    on<UpdateOperationsEvent>(onUpdateOperationsEvent);
    //
    on<AddDownloadOperationEvent>(onAddDownloadOperationEvent);
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
  onInitializeOperationsEvent(InitializeDownloadsEvent event, Emitter<DownloadsState> emit) async {
    //
    await emitContent(emit: emit);
    //
    _backgroundUpdateStateSubscription = FlutterBackgroundService().on("on-update-state").listen((event) {
      //
      //
      sl<DownloadsBloc>().add(const UpdateOperationsEvent());
      //
    });
    //
    _backgroundOnCompleteSubscription = FlutterBackgroundService().on("on-completed").listen((data) {
      //

      //
      //
      final operationId = data!['operation_id'] as int;
      final fileId = data['file_id'] as String;
      //
      if (state.operations.any((e) => e.file.id == fileId || e.id == operationId)) {
        sl<DownloadsBloc>().add(const CompleteOperationEvent());
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
        sl<DownloadsBloc>().add(const FailedOperationEvent());
      }
      //
    });
  }

  onUpdateOperationsEvent(UpdateOperationsEvent event, Emitter<DownloadsState> emit) async {
    await emitContent(emit: emit, operations: event.operations);
  }

  onAddDownloadOperationEvent(AddDownloadOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    Operation operation = Operation(
      id: 0,
      path: "${sl<AppPaths>().appPrivatePdfFilesPath}/${event.file.title}.${event.file.extension}",
      file: event.file,
      state: OperationState.pending,
      type: OperationType.download,
      date: DateTime.now(),
    );
    //
    emit(state.addOperation(operation));
    //
    //
    await _addOperationUseCase.call(operation: operation);
    //
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  onCompleteOperationEvent(CompleteOperationEvent event, Emitter<DownloadsState> emit) async {
    await sl<CacheManager>().refresh();
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  onFailedOperationEvent(FailedOperationEvent event, Emitter<DownloadsState> emit) async {
    await sl<CacheManager>().refresh();
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  onAddSharedOperationEvent(AddSharedOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    List<Operation> operations = [];
    //
    for (var path in event.paths) {
      operations.add(Operation(
        id: 0,
        path: path,
        file: BacFile.fromPath(path: path),
        state: OperationState.pending,
        type: OperationType.download,
        date: DateTime.now(),
      ));
    }
    //
    //
    await _addOperationsUseCase.call(operations: operations);
    //
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  onRefreshOperationEvent(RefreshOperationEvent event, Emitter<DownloadsState> emit) async {
    emitContent(emit: emit);
  }

  ///
  onStartOperationEvent(StartOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _updateOperationUseCase(
        operation: event.operation.copyWith(
      state: OperationState.pending,
    ));
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStartAllOperationsEvent(StartAllOperationsEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _updateAllOperationsStateUseCase(type: OperationType.upload, state: OperationState.pending);
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStopOperationEvent(StopOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _updateOperationUseCase(
        operation: event.operation.copyWith(
      state: OperationState.initializing,
    ));
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onStopAllOperationEvent(StopAllOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _updateAllOperationsStateUseCase(
      type: OperationType.upload,
      state: OperationState.initializing,
    );
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onDeleteOperationEvent(DeleteOperationEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _deleteOperationUseCase.call(operationId: event.operation.id);
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  ///
  onDeleteAllOperationsEvent(DeleteAllOperationsEvent event, Emitter<DownloadsState> emit) async {
    //
    //
    await _deleteAllOperationUseCase.call(type: OperationType.download);
    //
    sl<DownloadsBloc>().add(const UpdateOperationsEvent());
  }

  Future<void> emitContent({required Emitter<DownloadsState> emit, List<Operation>? operations}) async {
    ///
    if (operations != null) {
      emit(DownloadsState.content(operations: List.from(operations)));
      return;
    }
    //
    //
    final operationsResponse = await _getOperationsUseCase(type: OperationType.download);

    ///
    operationsResponse.fold(
      (l) {
        if (!emit.isDone) {
          emit(DownloadsState.failure(failure: l));
        }
      },
      (r) {
        if (!emit.isDone) {
          emit(DownloadsState.content(operations: List.from(r)));
        }
      },
    );
  }

  ///
  @override
  Future<void> close() {
    _backgroundUpdateStateSubscription.cancel();
    _backgroundOnCompleteSubscription.cancel();
    _backgroundOnFailedSubscription.cancel();
    return super.close();
  }
}
