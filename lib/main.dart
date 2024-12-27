import 'package:bac_files/core/services/background_service/background_service.dart';
import 'package:bac_files/core/services/cache/cache_manager.dart';
import 'package:bac_files/core/services/paths/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:bac_files/presentation/root/views/app_root.dart';
import 'core/injector/app_injection.dart';
import 'core/services/notifications/app_notification_service.dart';

void main() async {
  ///
  WidgetsFlutterBinding.ensureInitialized();

  ///
  ServiceLocator.init();

  ///
  await sl<CacheManager>().init();

  ///
  await sl<AppPaths>().init();

  ///
  await sl<AppNotificationsService>().initializeNotification();

  ///
  await sl<AppBackgroundService>().initializeBackgroundServiceForUploads();

  ///
  FlutterError.onError = (details) async {
    await ErrorsCopier().addErrorLogs("${details.exception.toString()}\n ${details.stack.toString()}");
  };

  ///
  runApp(AppRoot());
}

class ErrorsCopier {
  ///
  // Private constructor for singleton pattern
  ErrorsCopier._privateConstructor();

  // The single instance
  static final ErrorsCopier _instance = ErrorsCopier._privateConstructor();

  // Factory constructor to return the same instance every time
  factory ErrorsCopier() => _instance;

  ///
  final List<String> errors = List.empty(growable: true);

  static List<String> get errorsList => _instance.errors;

  ///
  Future<void> addErrorLogs(String details) async {
    errors.add(details);
  }
}
