import 'package:bac_files_admin/presentation/root/state/theme/app_theme_bloc.dart';

class CacheConstant {
  static const String cacheSubDir = '/app_cache';
  static const String boxName = 'hive_cache';
  static const int cacheValidSeconds = (60) * (60) * (24) * (7);

  ///
  static const String appThemeKey = 'app_theme_key';
}
