import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/services/notifications/app_notification_service.dart';
import 'package:bac_files/core/services/notifications/local/app_local_notifications.dart';
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
