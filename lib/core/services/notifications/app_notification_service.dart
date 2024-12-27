import 'package:bac_files/core/services/notifications/local/app_local_notifications.dart';
import 'package:bac_files/core/services/notifications/local/app_local_notifications_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class AppNotificationsService {
  //
  Future<void> initializeNotification();
  //
  Future<void> showProgressNotification({required int id, required String name, required int sent, required int total, AndroidNotificationChannel? channel});

  //
  Future<void> showMessageNotification({int? id, required String title, required String message, NotificationDetails? details});
  //
  Future<void> cancelNotification({required int id});
}

class AppNotificationsServiceImplement implements AppNotificationsService {
  ///
  final LocalNotificationsRepository localNotificationsService;

  ///
  AppNotificationsServiceImplement({required this.localNotificationsService});

  ///
  @override
  Future<void> initializeNotification() async {
    ///
    await localNotificationsService.initialize();

    ///
    return;
  }

  ///
  @override
  Future<void> showProgressNotification({required int id, required String name, required int sent, required int total, AndroidNotificationChannel? channel}) async {
    ///
    late final NotificationDetails details;

    ///
    details = NotificationDetails(
      android: AndroidNotificationDetails(
        channel?.id ?? AppLocalNotificationsSettings.defaultChannel.id,
        channel?.name ?? AppLocalNotificationsSettings.defaultChannel.name,
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        maxProgress: total,
        progress: sent,
        indeterminate: total == 0,
        playSound: false,
        enableLights: false,
        enableVibration: false,
        silent: true,
        actions: [
          const AndroidNotificationAction(
            'action_1',
            'الغاء العملية',
          ),
        ],
      ),
      iOS: const DarwinNotificationDetails(),
    );

    ///
    localNotificationsService.showNotification(
      id: id,
      title: name,
      body: "${((sent / total) * 100).toStringAsFixed(2)}%",
      details: details,
    );

    ///
    return;
  }

  ///
  @override
  Future<void> showMessageNotification({int? id, required String title, required String message, NotificationDetails? details}) async {
    ///
    localNotificationsService.showNotification(
      id: id ?? DateTime.now().millisecond,
      title: title,
      body: message,
      details: details ?? AppLocalNotificationsSettings.defaultNotificationsChannelDetails,
    );

    ///
    return;
  }

  ///
  @override
  Future<void> cancelNotification({required int id}) async {
    await localNotificationsService.cancelNotification(id: id);
    return;
  }
}
