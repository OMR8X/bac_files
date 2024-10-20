import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/uploads/data/datasources/background_uploads_data_source.dart';
import 'package:bac_files_admin/features/uploads/data/repositories/background_uploads_repository_implements.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operation_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../features/uploads/data/repositories/background_messagner_repository_implements.dart';
import '../../features/uploads/domain/entities/background_uploads_state.dart';
import '../../features/uploads/domain/repositories/background_messenger_repository.dart';
import '../../features/uploads/domain/repositories/background_uploads_repository.dart';
import '../../features/uploads/domain/usecases/operations/update_operations_usecase.dart';
import '../services/notifications/app_notification_service.dart';

backgroundInjection({required ServiceInstance service}) async {
  //
  sl.registerSingleton<ServiceInstance>(service);
  //
  sl.registerSingleton<BackgroundUploadsState>(BackgroundUploadsState());
  //
  sl.registerLazySingleton<FlutterBackgroundService>(() => FlutterBackgroundService());
  //
  sl.registerFactory<BackgroundMessengerRepository>(
    () => BackgroundMessengerRepositoryImplements(
      appNotificationService: sl<AppNotificationsService>(),
      serviceInstance: service,
    ),
  );

  /// [Datasources]
  sl.registerFactory<BackgroundUploadsDataSource>(
    () => BackgroundUploadsDataSourceImplements(
      cacheManager: sl<CacheManager>(),
      getOperationsUseCase: sl<GetAllOperationsUseCase>(),
      uploadFileUsecase: sl<UploadFileUsecase>(),
      updateOperationUseCase: sl<UpdateOperationUseCase>(),
      backgroundMessengerRepository: sl<BackgroundMessengerRepository>(),
      getOperationUseCase: sl<GetOperationUseCase>(),
      updateAllOperationsStateUseCase: sl<UpdateAllOperationsStateUseCase>(),
    ),
  );

  /// [Repositories]
  sl.registerFactory<BackgroundUploadsRepository>(
    () => BackgroundUploadsRepositoryImplements(
      cacheManager: sl<CacheManager>(),
      backgroundUploadsDataSource: sl<BackgroundUploadsDataSource>(),
    ),
  );
}
