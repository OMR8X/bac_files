import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/notifications/app_notification_service.dart';
import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

notificationsInjection() async {
  ///
  sl.registerSingleton<FlutterLocalNotificationsPlugin>(FlutterLocalNotificationsPlugin());

  ///
  sl.registerLazySingleton<LocalNotificationsRepository>(
    () => LocalNotificationsRepositoryImplements(
      notificationsPlugin: sl(),
    ),
  );

  ///
  sl.registerLazySingleton<AppNotificationsService>(
    () => AppNotificationsServiceImplement(
      localNotificationsService: sl(),
    ),
  );
}
