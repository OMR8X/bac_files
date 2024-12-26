import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';

debuggingInjection() async {
  sl.registerSingleton<DebuggingManager>(DebuggingManager()..init());
}
