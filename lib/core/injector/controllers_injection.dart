import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/cache/cache_constant.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/get_file_usecase.dart';
import 'package:bac_files_admin/features/files/domain/usecases/update_file_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/update_operation_usecase.dart';
import 'package:bac_files_admin/presentation/files/state/create_file/create_file_bloc.dart';
import 'package:bac_files_admin/presentation/managers/state/managers_view/managers_view_bloc.dart';
import 'package:bac_files_admin/presentation/root/state/loader/app_loader_bloc.dart';
import 'package:bac_files_admin/presentation/root/state/theme/app_theme_bloc.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../features/files/domain/usecases/get_all_files_usecase.dart';
import '../../features/managers/domain/usecases/select_managers_usecase.dart';
import '../../features/uploads/domain/usecases/operations/add_operation_usecase.dart';
import '../../features/uploads/domain/usecases/operations/delete_operation_usecase.dart';
import '../../features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import '../../presentation/files/state/delete_file/delete_file_bloc.dart';
import '../../presentation/files/state/explore_file/explore_file_bloc.dart';
import '../../presentation/files/state/update_file/update_file_bloc.dart';
import '../../presentation/files/state/update_operation_file/update_operation_file_bloc.dart';
import '../../presentation/home/state/bloc/home_bloc.dart';
import '../../presentation/uploads/state/uploads/uploads_bloc.dart';

controllersInjection() {
  ///
  sl.registerSingleton(AppThemeBloc(
    cacheManager: sl<CacheManager>(),
    appThemeKey: CacheConstant.appThemeKey,
  ));

  ///
  sl.registerSingleton(AppLoaderBloc(
    sl<SelectManagersUseCase>(),
  ));

  ///
  sl.registerSingleton(ManagersViewBloc(
    sl<SelectManagersUseCase>(),
  )..add(const ManagersViewInitializeEvent()));

  ///
  sl.registerSingleton(HomeBloc(
    sl<GetAllFilesUsecase>(),
    sl<DeleteFileUsecase>(),
  )..add(const HomeLoadFilesEvent()));

  ///
  sl.registerSingleton(UploadsBloc(
    sl<GetAllOperationsUseCase>(),
    sl<AddOperationUseCase>(),
    sl<DeleteOperationUseCase>(),
    sl<UpdateOperationUseCase>(),
    sl<CacheManager>(),
  ));

  ///
  sl.registerFactory<CreateFileBloc>(
    () => CreateFileBloc(),
  );

  ///
  sl.registerFactory<UpdateFileBloc>(
    () => UpdateFileBloc(
      sl<GetFileUsecase>(),
      sl<UpdateFileUsecase>(),
    ),
  );

  ///
  sl.registerFactory<DeleteFileBloc>(
    () => DeleteFileBloc(
      sl<DeleteFileUsecase>(),
    ),
  );

  ///
  sl.registerFactory<UpdateOperationFileBloc>(
    () => UpdateOperationFileBloc(
      sl<UpdateOperationUseCase>(),
      sl<GetAllOperationsUseCase>(),
    ),
  );

  ///
  sl.registerFactory<ExploreFileBloc>(
    () => ExploreFileBloc(
      sl<GetFileUsecase>(),
    ),
  );
}
