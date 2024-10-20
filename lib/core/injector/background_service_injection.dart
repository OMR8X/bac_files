import 'package:bac_files_admin/core/injector/app_injection.dart';
import '../services/background_service/background_service.dart';

backgroundServiceInjection() {
  sl.registerFactory<AppBackgroundService>(
    () => AppBackgroundServiceImplements(),
  );
}
