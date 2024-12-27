import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/services/debug/debugging_manager.dart';

debuggingInjection() async {
  sl.registerSingleton<DebuggingManager>(DebuggingManager()..init());
}
