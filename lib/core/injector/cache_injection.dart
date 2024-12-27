import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/services/cache/cache_manager.dart';

import '../services/cache/cache_client.dart';

cacheInjection() async {
  sl.registerSingleton<CacheClient>(HiveClient());
  sl.registerSingleton<CacheManager>(CacheManager(sl<CacheClient>()));
}
