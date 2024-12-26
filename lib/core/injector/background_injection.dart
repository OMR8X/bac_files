import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/downloads/domain/entities/background_downloads_state.dart';
import 'package:bac_files_admin/features/downloads/domain/repositories/background_downloads_messenger_repository.dart';
import 'package:bac_files_admin/features/files/domain/usecases/download_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/uploads/data/datasources/background_uploads_data_source.dart';
import 'package:bac_files_admin/features/uploads/data/repositories/background_uploads_repository_implements.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../features/downloads/data/datasources/background_downloads_data_source.dart';
import '../../features/downloads/data/repositories/background_downloads_repository_implements.dart';
import '../../features/downloads/data/repositories/background_messenger_repository_implements.dart';
import '../../features/downloads/domain/repositories/background_downloads_repository.dart';
import '../../features/operations/domain/usecases/update_operation_usecase.dart';
import '../../features/uploads/domain/entities/background_uploads_state.dart';
import '../../features/uploads/domain/repositories/background_uploads_repository.dart';
import '../services/notifications/app_notification_service.dart';

backgroundInjection({required ServiceInstance service}) async {
  //
  sl.registerSingleton<ServiceInstance>(service);
  //
  sl.registerSingleton<BackgroundUploadsState>(BackgroundUploadsState());
  //
  sl.registerSingleton<BackgroundDownloadsState>(BackgroundDownloadsState());
  //
  sl.registerLazySingleton<FlutterBackgroundService>(() => FlutterBackgroundService());

  ///[Repositories]
  sl.registerFactory<BackgroundMessengerRepository>(
    () => BackgroundMessengerRepositoryImplements(
      appNotificationService: sl<AppNotificationsService>(),
      serviceInstance: service,
    ),
  );

  /// [Datasources]
  sl.registerFactory<BackgroundDownloadsDataSource>(
    () => BackgroundDownloadsDataSourceImplements(
      cacheManager: sl<CacheManager>(),
      uploadFileUsecase: sl<DownloadFileUsecase>(),
      updateOperationUseCase: sl<UpdateOperationUseCase>(),
      backgroundMessengerRepository: sl<BackgroundMessengerRepository>(),
    ),
  );
  sl.registerFactory<BackgroundUploadsDataSource>(
    () => BackgroundUploadsDataSourceImplements(
      uploadFileUsecase: sl<UploadFileUsecase>(),
      updateOperationUseCase: sl<UpdateOperationUseCase>(),
      backgroundMessengerRepository: sl<BackgroundMessengerRepository>(),
    ),
  );

  /// [Repositories]
  sl.registerFactory<BackgroundUploadsRepository>(
    () => BackgroundUploadsRepositoryImplements(
      cacheManager: sl<CacheManager>(),
      backgroundUploadsDataSource: sl<BackgroundUploadsDataSource>(),
    ),
  );
  sl.registerFactory<BackgroundDownloadsRepository>(
    () => BackgroundDownloadsRepositoryImplements(
      cacheManager: sl<CacheManager>(),
      backgroundDownloadsDataSource: sl<BackgroundDownloadsDataSource>(),
    ),
  );
}
