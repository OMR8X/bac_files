import 'package:bac_files_admin/core/services/cache/cache_manager.dart';

import '../../../../core/resources/errors/exceptions.dart';
import '../../domain/requests/select_entities_request.dart';
import '../../domain/requests/select_entity_request.dart';
import '../converters/managers_base_converter.dart';
import '../responses/select_entities_response.dart';
import '../responses/select_entity_response.dart';

abstract class ManagersLocalDataSource {
  // select
  Future<SelectEntityResponse<T>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  });
}

class ManagersLocalDataSourceImplements implements ManagersLocalDataSource {
  final CacheManager _cacheManager;

  ManagersLocalDataSourceImplements({required CacheManager cacheManager}) : _cacheManager = cacheManager;

  @override
  Future<SelectEntityResponse<T>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  }) async {
    //
    final dataKey = apiEndpoint;
    //
    await _cacheManager.checkIsValid(dataKey);
    //
    final data = await _cacheManager().read(dataKey);
    //
    if (data == null) throw const CacheEmptyException();
    //
    return SelectEntityResponse.fromCache(
      data: data,
      converter: converter,
    );
  }
}
