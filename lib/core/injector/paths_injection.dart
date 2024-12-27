import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/services/paths/app_paths.dart';

pathsInjection() async {
  sl.registerSingleton<AppPaths>(AppPaths());
}
