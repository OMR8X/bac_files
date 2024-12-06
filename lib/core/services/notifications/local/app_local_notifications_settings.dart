import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppLocalNotificationsSettings {
  ///
  static const InitializationSettings settings = InitializationSettings(
    iOS: DarwinInitializationSettings(),
    android: AndroidInitializationSettings("icon"),
  );

  ///
  static const defaultChannel = AndroidNotificationChannel(
    "مدير العمليات",
    "مدير العمليات",
    importance: Importance.min,
    playSound: false,
    enableVibration: false,
    enableLights: false,
  );

  ///
  static const uploadsChannel = AndroidNotificationChannel(
    "عمليات الرفع",
    "عمليات الرفع",
    importance: Importance.min,
    playSound: false,
    enableVibration: false,
    enableLights: false,
  );
  static const downloadsChannel = AndroidNotificationChannel(
    "عمليات التنزيل",
    "عمليات التنزيل",
    importance: Importance.min,
    playSound: false,
    enableVibration: false,
    enableLights: false,
  );

  /// default
  static const List<AndroidNotificationChannel> channels = [defaultChannel, uploadsChannel, downloadsChannel];

  ///
  static NotificationDetails defaultNotificationsChannelDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      defaultChannel.id,
      defaultChannel.name,
      importance: Importance.min,
      priority: Priority.min,
      playSound: false,
      enableVibration: false,
      enableLights: false,
    ),
    iOS: const DarwinNotificationDetails(
      badgeNumber: 1,
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
      subtitle: 'Subtitle goes here',
      threadIdentifier: 'thread_id',
    ),
  );

  ///
  static NotificationDetails uploadsChannelDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      uploadsChannel.id,
      uploadsChannel.name,
      importance: Importance.min,
      priority: Priority.min,
      playSound: false,
      enableVibration: false,
      enableLights: false,
    ),
    iOS: const DarwinNotificationDetails(),
  );

  ///
  static NotificationDetails downloadsChannelDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      downloadsChannel.id,
      downloadsChannel.name,
      importance: Importance.min,
      priority: Priority.min,
      playSound: false,
      enableVibration: false,
      enableLights: false,
    ),
    iOS: const DarwinNotificationDetails(),
  );
}
