import 'package:bac_files_admin/core/services/background_service/background_service.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:bac_files_admin/presentation/root/views/app_root.dart';
import 'core/injector/app_injection.dart';
import 'core/services/notifications/app_notification_service.dart';

void main() async {
  ///
  ServiceLocator.init();

  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  await sl<CacheManager>().init();

  ///
  await sl<AppNotificationsService>().initializeNotification();

  ///
  await sl<AppBackgroundService>().initializeBackgroundServiceForUploads();

  ///
  runApp(
    const AppRoot(),
  );
}
