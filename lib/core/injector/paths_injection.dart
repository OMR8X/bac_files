import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/paths/app_paths.dart';


pathsInjection() async {
  sl.registerSingleton<AppPaths>(AppPaths());
}
