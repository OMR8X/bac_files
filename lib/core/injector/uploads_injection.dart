import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/features/uploads/data/repositories/operations_repository_implement.dart';
import 'package:bac_files_admin/features/uploads/domain/repositories/operations_repository.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/add_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/add_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/delete_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/start_all_uploads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/start_upload_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/stop_all_uploads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/stop_upload_usecase.dart';
import '../../features/uploads/data/datasources/operations_local_datasource.dart';
import '../../features/uploads/domain/usecases/operations/delete_all_operation_usecase.dart';
import '../../features/uploads/domain/usecases/operations/get_operation_usecase.dart';
import '../../features/uploads/domain/usecases/operations/update_operations_usecase.dart';
import '../../features/uploads/domain/usecases/uploads/refresh_uploads_usecase.dart';

uploadsInjection() {
  ///
  /// [ Data Sources ]
  sl.registerFactory<OperationsLocalDataSource>(
    () => OperationsLocalDataSourceImplement(
      cacheManager: sl(),
    ),
  );

  ///
  /// [ Repositories ]
  sl.registerFactory<OperationsRepository>(
    () => OperationsRepositoryImplement(
      localDataSource: sl(),
    ),
  );

  ///
  /// [Use Cases]
  sl.registerFactory<GetOperationUseCase>(
    () => GetOperationUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<GetAllOperationsUseCase>(
    () => GetAllOperationsUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<AddOperationUseCase>(
    () => AddOperationUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<AddOperationsUseCase>(
    () => AddOperationsUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<UpdateOperationUseCase>(
    () => UpdateOperationUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<UpdateAllOperationsStateUseCase>(
    () => UpdateAllOperationsStateUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<DeleteOperationUseCase>(
    () => DeleteOperationUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<DeleteAllOperationUseCase>(
    () => DeleteAllOperationUseCase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<StartUploadUsecase>(
    () => StartUploadUsecase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<StartAllUploadsUsecase>(
    () => StartAllUploadsUsecase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<StopUploadUsecase>(
    () => StopUploadUsecase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<StopAllUploadsUsecase>(
    () => StopAllUploadsUsecase(
      repository: sl(),
    ),
  );

  ///
  sl.registerFactory<RefreshUploadsUsecase>(
    () => RefreshUploadsUsecase(
      repository: sl(),
    ),
  );
}
