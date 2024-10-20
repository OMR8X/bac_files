import 'package:bac_files_admin/core/services/notifications/app_notification_service.dart';
import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../domain/repositories/background_messenger_repository.dart';

class BackgroundMessengerRepositoryImplements implements BackgroundMessengerRepository {
  final ServiceInstance _serviceInstance;
  final AppNotificationsService _appNotificationService;

  BackgroundMessengerRepositoryImplements({
    required ServiceInstance serviceInstance,
    required AppNotificationsService appNotificationService,
  })  : _serviceInstance = serviceInstance,
        _appNotificationService = appNotificationService;

  @override
  Future<void> sendUpdateState() async {
    //
    debugPrint("6- sending update state message..");
    //
    _serviceInstance.invoke("on-update-state");
    //
    return;
  }

  @override
  Future<void> sendOperationCompletedMessage({required int id, required String title}) async {
    //
    debugPrint("sending operation completed message..");
    //
    _serviceInstance.invoke("on-completed", {
      "operation_id": id,
    });
    //
    _appNotificationService.showMessageNotification(
      id: id,
      title: "تمت العملية",
      message: "تم رفع $title",
      details: AppLocalNotificationsSettings.uploadsChannelDetails,
    );
    return;
  }

  @override
  Future<void> sendOperationFailed({required int id, required String title}) async {
    //
    debugPrint("sending operation failed message..");
    //
    _serviceInstance.invoke("on-failed", {
      "operation_id": id,
    });
    //
    _appNotificationService.showMessageNotification(
      id: id,
      title: "فشلت العملية",
      message: "حدث خطا اثناء محاولة رفع $title",
      details: AppLocalNotificationsSettings.uploadsChannelDetails,
    );
    return;
  }

  @override
  Future<void> sendProgressMessageMessage({
    required int id,
    required String title,
    required int sent,
    required int total,
  }) async {
    //
    debugPrint("sending progress message..");
    //
    _serviceInstance.invoke("on-progress", {
      "operation_id": id,
      "sent": sent,
      "total": total,
    });
    //
    _appNotificationService.showProgressNotification(
      id: id,
      name: title,
      sent: sent,
      total: total,
      channel: AppLocalNotificationsSettings.uploadsChannel,
    );
    return;
  }
}
