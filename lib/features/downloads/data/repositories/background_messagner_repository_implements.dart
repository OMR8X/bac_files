import 'package:bac_files_admin/core/services/notifications/app_notification_service.dart';
import 'package:bac_files_admin/core/services/notifications/local/app_local_notifications_settings.dart';
import 'package:bac_files_admin/features/operations/data/mappers/operation_mapper.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/injector/app_injection.dart';
import '../../../../core/services/debug/debugging_client.dart';
import '../../../../core/services/debug/debugging_manager.dart';
import '../../../operations/domain/entities/operation.dart';

import '../../domain/repositories/background_downloads_messenger_repository.dart';

class BackgroundMessengerRepositoryImplements implements BackgroundMessengerRepository {
  final ServiceInstance _serviceInstance;
  final AppNotificationsService _appNotificationService;

  BackgroundMessengerRepositoryImplements({
    required ServiceInstance serviceInstance,
    required AppNotificationsService appNotificationService,
  })  : _serviceInstance = serviceInstance,
        _appNotificationService = appNotificationService;

  @override
  Future<void> sendUpdateState({List<Operation>? operations, required OperationType type}) async {
    //
    _serviceInstance.invoke("on-update-state", {});
    //
    return;
  }

  @override
  Future<void> sendOperationCompletedMessage({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
  }) async {
    //
    _serviceInstance.invoke("on-completed", {
      "file_id": fileId,
      "operation_id": operationId,
    });
    //
    await _appNotificationService.showMessageNotification(
      id: operationId,
      title: "تمت العملية",
      message: "تم ${operationType == OperationType.download ? "تحميل" : "رفع"} $title",
      details: AppLocalNotificationsSettings.defaultNotificationsChannelDetails,
    );
    //
  }

  @override
  Future<void> sendOperationFailed({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
  }) async {
    //
    _serviceInstance.invoke("on-failed", {
      "file_id": fileId,
      "operation_id": operationId,
    });
    //
    await _appNotificationService.showMessageNotification(
      id: operationId,
      title: "فشلت العملية",
      message: "حدث خطا اثناء محاولة ${operationType == OperationType.download ? "تحميل" : "رفع"} $title",
      details: AppLocalNotificationsSettings.defaultNotificationsChannelDetails,
    );
    //
    return;
  }

  @override
  Future<void> sendProgressMessageMessage({
    required int operationId,
    required OperationType operationType,
    required String fileId,
    required String title,
    required int sent,
    required int total,
  }) async {
    //
    _serviceInstance.invoke("on-progress", {
      "file_id": fileId,
      "operation_id": operationId,
      "sent": sent,
      "total": total,
    });
    //
    _appNotificationService.showProgressNotification(
      id: operationId,
      name: title,
      sent: sent,
      total: total,
      channel: AppLocalNotificationsSettings.defaultChannel,
    );
    //
    if (sent == total) {
      await _appNotificationService.cancelNotification(id: operationId);
    }
    return;
  }
}
