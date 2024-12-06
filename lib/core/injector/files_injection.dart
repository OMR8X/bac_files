import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:bac_files_admin/features/files/data/datasources/files_remote_datasource.dart';
import 'package:bac_files_admin/features/files/data/repositories/file_repository_implement.dart';
import 'package:bac_files_admin/features/files/domain/repositories/files_repository.dart';
import 'package:bac_files_admin/features/files/domain/usecases/download_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/get_all_files_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/get_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/update_file_usecase.dart';

filesInjection() {
  ///
  /// [ Data Sources ]
  sl.registerFactory<FilesRemoteDataSource>(
    () => FilesRemoteDataSourceImplements(
      manager: sl<ApiManager>(),
    ),
  );

  ///
  /// [ Repositories ]
  sl.registerFactory<FilesRepository>(
    () => FilesRepositoryImplement(
      remoteDataSource: sl<FilesRemoteDataSource>(),
    ),
  );

  ///
  /// [Use Cases]
  sl.registerFactory<UploadFileUsecase>(
    () => UploadFileUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DownloadFileUsecase>(
    () => DownloadFileUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteFileUsecase>(
    () => DeleteFileUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory<GetAllFilesUsecase>(
    () => GetAllFilesUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory<GetFileUsecase>(
    () => GetFileUsecase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateFileUsecase>(
    () => UpdateFileUsecase(
      repository: sl(),
    ),
  );
}
