import 'package:bac_files_admin/core/injector/cache_injection.dart';
import 'package:bac_files_admin/core/injector/managers_injection.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:get_it/get_it.dart';
import 'background_injection.dart';
import 'background_service_injection.dart';
import 'client_injection.dart';
import 'controllers_injection.dart';
import 'files_injection.dart';
import 'debugging_injection.dart';
import 'notifications_injection.dart';
import 'uploads_injection.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ///
  static void init() {
    injectServices();
    initFeatures();
    initControllers();
  }

  /// Services
  static void injectServices() {
    notificationsInjection();
    cacheInjection();
    debuggingInjection();
  }

  /// Features
  static void initFeatures() {
    clientInjection();
    managersInjection();
    filesInjection();
    uploadsInjection();
    backgroundServiceInjection();
  }

  static void initBackground({required ServiceInstance service}) {
    backgroundInjection(service: service);
  }

  /// controllers
  static void initControllers() {
    controllersInjection();
  }
}