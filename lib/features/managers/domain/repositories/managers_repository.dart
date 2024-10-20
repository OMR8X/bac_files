import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/managers/data/responses/create_entity_response.dart';
import 'package:bac_files_admin/features/managers/data/responses/delete_entity_response.dart';
import 'package:bac_files_admin/features/managers/data/responses/select_entities_response.dart';
import 'package:bac_files_admin/features/managers/data/responses/select_entity_response.dart';
import 'package:bac_files_admin/features/managers/data/responses/update_entity_response.dart';
import 'package:bac_files_admin/features/managers/domain/requests/create_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entities_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/update_entity_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/converters/managers_base_converter.dart';

abstract class ManagersRepository {
  // add
  Future<Either<Failure, CreateEntityResponse>> createEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required CreateEntityRequest<T> request,
  });
  // delete
  Future<Either<Failure, DeleteEntityResponse>> deleteEntity<T>({
    required String apiEndpoint,
    required DeleteEntityRequest request,
  });
  // select
  Future<Either<Failure, SelectEntitiesResponse<T>>> selectEntities<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntitiesRequest request,
  });
  //
  Future<Either<Failure, SelectEntityResponse<T>>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  });
  // update
  Future<Either<Failure, UpdateEntityResponse>> updateEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required UpdateEntityRequest<T> request,
  });
}
