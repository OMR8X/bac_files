import 'dart:async';
import 'dart:ui';
import 'package:bac_files/core/services/background_service/background_constants.dart';
import 'package:bac_files/core/services/background_service/messages/add_operations.dart';
import 'package:bac_files/core/services/background_service/messages/remove_all_operations.dart';
import 'package:bac_files/core/services/background_service/messages/remove_operations.dart';
import 'package:bac_files/core/services/debug/debugging_manager.dart';
import 'package:bac_files/core/services/notifications/app_notification_service.dart';
import 'package:bac_files/features/uploads/domain/entities/background_uploads_state.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../injector/app_injection.dart';
import '../cache/cache_manager.dart';
import '../notifications/local/app_local_notifications_settings.dart';
import 'background_service.dart';

@pragma('vm:entry-point')
Future<void> backgroundFunction(ServiceInstance service) async {
  ///

  DartPluginRegistrant.ensureInitialized();

  ///
  ServiceLocator.init();

  ///
  ServiceLocator.initBackground(service: service);

  ///
  await sl<CacheManager>().init();

  if (service is AndroidServiceInstance) {
    ///
    if (await service.isForegroundService()) {
      //
      await sl<AppNotificationsService>().initializeNotification();
      //
      startTimer();
      //
      registerRegisters(service);
      //
    }
  } else if (service is IOSServiceInstance) {
    //
    await sl<AppNotificationsService>().initializeNotification();
    //
    registerRegisters(service);
  }
}

void registerRegisters(ServiceInstance service) {
  AddOperationsMessenger().register(service);
  RemoveOperationMessenger().register(service);
  RemoveAllOperationMessenger().register(service);
}

void startTimer() {
  // timer
  Timer.periodic(const Duration(seconds: 10), (t) async {
    await sl<AppNotificationsService>().showMessageNotification(
      title: 'رفع الملفات',
      message: "مدير الملفات يعمل في الخلفية",
      id: initializingNotificationId,
      details: AppLocalNotificationsSettings.defaultNotificationsChannelDetails,
    );
  });
}
