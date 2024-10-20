import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationsRepository {
  ///
  Future<void> initialize();

  ///
  Future<void> showNotification({required int id, String? title, String? body, NotificationDetails? details, String? payload});

  ///
  Future<void> cancelNotification({required int id});
  //
  Future<void> createChannel({required AndroidNotificationChannel channel});
}

class LocalNotificationsRepositoryImplements implements LocalNotificationsRepository {
  ///
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  ///
  LocalNotificationsRepositoryImplements({required this.notificationsPlugin});

  ///
  @override
  Future<void> initialize() async {
    ///
    const settings = AppLocalNotificationsSettings.settings;

    ///
    await _requestNotificationPermission();

    ///
    for (var channel in AppLocalNotificationsSettings.channels) {
      await createChannel(channel: channel);
    }

    ///
    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse? notificationResponse) {
        if (notificationResponse == null) {
          debugPrint(" NotificationResponse is null");
          return;
        }
        debugPrint("onDidReceiveNotificationResponse: ${notificationResponse.payload}");
        return;
      },
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    ///
    return;
  }

  ///
  @override
  Future<void> showNotification({required int id, String? title, String? body, NotificationDetails? details, String? payload}) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      details ?? AppLocalNotificationsSettings.defaultNotificationsChannelDetails,
      payload: "",
    );
  }

  ///
  @override
  Future<void> cancelNotification({required int id}) async {
    return await notificationsPlugin.cancel(id);
  }

  Future<void> _requestNotificationPermission() async {
    var status = await Permission.notification.status;
    print(status);
    if (status.isDenied) {
      status = await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      print(status);
      await openAppSettings();
    }
    print(status);
  }

  ///
  @override
  Future<void> createChannel({required AndroidNotificationChannel channel}) async {
    //
    await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    return;
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse? response) async {
  if (response == null) {
    debugPrint("Background NotificationResponse is null");
    return;
  }
  debugPrint("onDidReceiveBackgroundNotificationResponse: ${response.payload}");
  return;
}
