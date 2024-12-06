import 'package:bac_files_admin/core/injector/app_injection.dart';

import '../../features/uploads/domain/usecases/start_uploads_usecase.dart';

uploadsInjection() {
  ///
  /// [Use Cases]
  sl.registerFactory<StartUploadUsecase>(
    () => StartUploadUsecase(
      repository: sl(),
    ),
  );
}
