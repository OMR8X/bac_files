import 'dart:async';
import 'dart:ui';

import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications.dart';
import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'functions/uploads_function.dart';

const initializingNotificationId = 1;

abstract class AppBackgroundService {
  ///
  StreamSubscription<Map<String, dynamic>?> listenToMethod({
    required String method,
    required void Function(Map<String, dynamic>?) onData,
  });

  ///
  void invokeMethod({required String method, required Map<String, dynamic> data});

  ///
  Future<void> initializeBackgroundServiceForUploads();

  ///
  Future<void> startBackgroundService();

  ///
  Future<void> stopBackgroundService();
}

class AppBackgroundServiceImplements implements AppBackgroundService {
  // final FlutterBackgroundService service;

  AppBackgroundServiceImplements();

  ///
  @override
  void invokeMethod({required String method, required Map<String, dynamic> data}) async {
    FlutterBackgroundService().invoke(method, data);
    return;
  }

  @override
  StreamSubscription<Map<String, dynamic>?> listenToMethod({
    required String method,
    required void Function(Map<String, dynamic>?) onData,
  }) {
    return FlutterBackgroundService().on(method).listen((event) => onData(event));
  }

  ///

  @override
  Future<void> initializeBackgroundServiceForUploads() async {
    ///
    await sl<LocalNotificationsRepository>().initialize();

    ///
    await FlutterBackgroundService().configure(
      ///
      androidConfiguration: AndroidConfiguration(
        onStart: onStartUploadsFunction,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: AppLocalNotificationsSettings.uploadsChannel.id,
        initialNotificationTitle: AppLocalNotificationsSettings.uploadsChannel.name,
        initialNotificationContent: 'جار رفع الملفات',
        foregroundServiceNotificationId: initializingNotificationId,
        foregroundServiceTypes: [
          AndroidForegroundType.dataSync,
        ],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onBackground: onIosBackground,
        onForeground: onStartUploadsFunction,
      ),
    );
    return;
  }

  ///
  @override
  Future<void> startBackgroundService() async {
    try {
      await FlutterBackgroundService().startService();
      return;
    } on Exception {
      return;
    }
  }

  ///
  @override
  Future<void> stopBackgroundService() async {
    try {
      FlutterBackgroundService().invoke("stop");
      return;
    } on Exception {
      return;
    }
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance serviceInstance) async {
  return true;
}

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  // if (service is AndroidServiceInstance) {
  //   service.on('setAsForeground').listen((event) {
  //     service.setAsForegroundService();
  //   });

  //   service.on('setAsBackground').listen((event) {
  //     service.setAsBackgroundService();
  //   });
  // }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

// I setted it to 5" to have a quick feedback
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    // if (service is AndroidServiceInstance) {
    //   service.setForegroundNotificationInfo(
    //     title: "My App Service",
    //     content: "Updated at ${DateTime.now()}",
    //   );
    // }

    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
      },
    );
  });
}