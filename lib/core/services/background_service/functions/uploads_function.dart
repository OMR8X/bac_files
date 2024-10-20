import 'dart:async';
import 'dart:ui';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/core/services/notifications/app_notification_service.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/operations/get_operations_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/refresh_uploads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/start_all_uploads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/start_upload_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/stop_all_uploads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/uploads/stop_upload_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:logger/logger.dart';
import '../../../injector/app_injection.dart';
import '../../cache/cache_manager.dart';
import '../background_service.dart';

@pragma('vm:entry-point')
Future<void> onStartUploadsFunction(ServiceInstance service) async {
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
      Timer.periodic(const Duration(seconds: 10), (t) async {
        await sl<AppNotificationsService>().showMessageNotification(
          title: 'رفع الملفات',
          message: "مدير الملفات يعمل في الخلفية",
          id: initializingNotificationId,
        );
      });
      //
      await sl<AppNotificationsService>().initializeNotification();
      //
      initializeListeners(service);
    }
  } else if (service is IOSServiceInstance) {
    //
    await sl<AppNotificationsService>().initializeNotification();
    //
    initializeListeners(service);
    //
    service.on("use_it").listen((event) async {
      try {
        sl<GetAllOperationsUseCase>().call().then((response) {
          response.fold(
            (l) {
              debugPrint("use_it -> error : $l");
            },
            (r) {
              debugPrint("use_it -> all good");
            },
          );
        });
      } on Exception catch (e) {
        debugPrint("use_it -> error : $e");
      }
    });
  }
}

void initializeListeners(ServiceInstance service) {
  ///
  service.on("start_upload").listen((event) async {
    //
    final operationID = event?['operation_id'] as int?;
    //
    if (operationID == null) {
      sl<DebuggingManager>()().logWarning(
        "start_upload event received but operationID is null",
      );
      return;
    }
    //
    sl<DebuggingManager>()().logMessage(
      "start_upload event received, starting upload for operationID: $operationID",
    );
    //
    sl<StartUploadUsecase>().call(operationID: operationID);
  });

  ///
  service.on("start_all_uploads").listen((event) async {
    //
    sl<DebuggingManager>()().logMessage(
      "start_all_uploads event received, starting all uploads",
    );
    //
    sl<StartAllUploadsUsecase>().call();
    //
  });

  ///
  service.on("stop_upload").listen((event) async {
    //
    final operationID = event?['operation_id'] as int?;
    //
    if (operationID == null) {
      sl<DebuggingManager>()().logWarning(
        "stop_upload event received but operationID is null",
      );
      return;
    }
    //
    sl<DebuggingManager>()().logMessage(
      "stop_upload event received, stopping upload for operationID: $operationID",
    );
    //
    sl<StopUploadUsecase>().call(operationID: operationID);
    //
  });

  ///
  service.on("stop_all_uploads").listen((event) async {
    //
    sl<DebuggingManager>()().logMessage(
      "2 - stop_all_uploads event received, stopping all uploads",
    );
    //
    sl<StopAllUploadsUsecase>().call();
  });

  ///
  service.on("refresh_uploads").listen((event) async {
    //
    sl<DebuggingManager>()().logMessage(
      "refresh_uploads event received, refreshing uploads",
    );
    //
    sl<RefreshUploadsUsecase>().call();
  });
}
