import '../../features/downloads/domain/usecases/start_downloads_usecase.dart';
import 'app_injection.dart';

downloadsInjection() {
  ///
  /// [Use Cases]
  sl.registerFactory<StartDownloadUsecase>(
    () => StartDownloadUsecase(
      repository: sl(),
    ),
  );
}
