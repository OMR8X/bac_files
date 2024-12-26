import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bac_files_admin/features/auth/data/repositories/auth_repository_implement.dart';
import 'package:bac_files_admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:bac_files_admin/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:bac_files_admin/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:bac_files_admin/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:bac_files_admin/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:bac_files_admin/features/auth/domain/usecases/update_user_data_usecase.dart';
import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';

authInjection() {
  injectUseCases();
  injectRepositories();
  injectDataSources();
}

void injectUseCases() {
  sl.registerFactory<GetUserDataUseCase>(
    () => GetUserDataUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<SignUpUseCase>(
    () => SignUpUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<SignInUseCase>(
    () => SignInUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<UpdateUserDataUseCase>(
    () => UpdateUserDataUseCase(repository: sl<AuthRepository>()),
  );
  sl.registerFactory<SignOutUseCase>(
    () => SignOutUseCase(repository: sl<AuthRepository>()),
  );
}

void injectRepositories() async {
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImplement(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
      cacheManager: sl<CacheManager>(),
    ),
  );
}

void injectDataSources() async {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplements(
      apiManager: sl<ApiManager>(),
    ),
  );
  sl.registerFactory<AuthLocalDataSource>(
    () => AuthLocalDataSourceImplements(
      cacheManager: sl<CacheManager>(),
    ),
  );
}
