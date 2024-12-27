import 'package:bac_files/core/injector/app_injection.dart';

import '../../features/operations/data/datasources/operations_local_datasource.dart';
import '../../features/operations/data/repositories/operations_repository_implement.dart';
import '../../features/operations/domain/repositories/operations_repository.dart';
import '../../features/operations/domain/usecases/add_operation_usecase.dart';
import '../../features/operations/domain/usecases/add_operations_usecase.dart';
import '../../features/operations/domain/usecases/delete_all_operation_usecase.dart';
import '../../features/operations/domain/usecases/delete_operation_usecase.dart';
import '../../features/operations/domain/usecases/get_operation_usecase.dart';
import '../../features/operations/domain/usecases/get_operations_usecase.dart';
import '../../features/operations/domain/usecases/update_operation_usecase.dart';
import '../../features/operations/domain/usecases/update_operations_usecase.dart';

operationsInjection() {
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
}
