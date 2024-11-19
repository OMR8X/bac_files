import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:bac_files_admin/features/managers/data/responses/select_entity_response.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entity_request.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/api/responses/api_response.dart';
import '../../domain/requests/create_entity_request.dart';
import '../../domain/requests/delete_entity_request.dart';
import '../../domain/requests/select_entities_request.dart';
import '../../domain/requests/update_entity_request.dart';
import '../converters/managers_base_converter.dart';
import '../responses/create_entity_response.dart';
import '../responses/delete_entity_response.dart';
import '../responses/select_entities_response.dart';
import '../responses/update_entity_response.dart';

abstract class ManagersRemoteDataSource {
  // select
  Future<SelectEntitiesResponse<T>> selectEntities<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntitiesRequest request,
  });
  // select
  Future<SelectEntityResponse<T>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  });
  // add
  Future<CreateEntityResponse> createEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter converter,
    required CreateEntityRequest<T> request,
  });
  // update
  Future<UpdateEntityResponse> updateEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required UpdateEntityRequest<T> request,
  });
  // delete
  Future<DeleteEntityResponse> deleteEntity<T>({
    required String apiEndpoint,
    required DeleteEntityRequest request,
  });
}

class ManagersRemoteDataSourceImplement implements ManagersRemoteDataSource {
  final ApiManager apiManager;

  ManagersRemoteDataSourceImplement({required this.apiManager});
  @override
  Future<CreateEntityResponse> createEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter converter,
    required CreateEntityRequest<T> request,
  }) async {
    ///
    final dioResponse = await apiManager().post(
      apiEndpoint,
      body: request.toBody(converter: converter),
    );

    ///
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);

    ///
    apiResponse.throwErrorIfExists();

    ///
    final response = CreateEntityResponse.fromApiResponse(response: apiResponse);

    ///
    return response;
  }

  @override
  Future<DeleteEntityResponse> deleteEntity<T>({
    required String apiEndpoint,
    required DeleteEntityRequest request,
  }) async {
    ///
    final dioResponse = await apiManager().delete(
      '$apiEndpoint/${request.id}',
    );

    ///
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);

    ///
    apiResponse.throwErrorIfExists();

    ///
    final response = DeleteEntityResponse.fromApiResponse(response: apiResponse);

    ///
    return response;
  }

  @override
  Future<SelectEntitiesResponse<T>> selectEntities<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntitiesRequest request,
  }) async {
    ///
    final dioResponse = await apiManager().get(
      apiEndpoint,
      queryParameters: request.queryParameters,
    );

    ///
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);

    ///
    apiResponse.throwErrorIfExists();

    ///
    final response = SelectEntitiesResponse<T>.fromApiResponse(
      response: apiResponse,
      converter: converter,
    );

    ///
    return response;
  }

  @override
  Future<SelectEntityResponse<T>> selectEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required SelectEntityRequest request,
  }) async {
    ///
    final dioResponse = await apiManager().get(
      '$apiEndpoint/${request.id}',
    );

    ///
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);

    ///
    apiResponse.throwErrorIfExists();

    final response = SelectEntityResponse<T>.fromApiResponse(
      response: apiResponse,
      converter: converter,
    );

    ///
    return response;
  }

  @override
  Future<UpdateEntityResponse> updateEntity<T>({
    required String apiEndpoint,
    required ManagersBaseConverter<T> converter,
    required UpdateEntityRequest<T> request,
  }) async {
    //
    final dioResponse = await apiManager().put(
      '$apiEndpoint/${request.id}',
      body: request.toBody(converter: converter),
    );
    //
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);
    // //
    apiResponse.throwErrorIfExists();
    //

    //
    final response = UpdateEntityResponse.fromApiResponse(response: apiResponse);
    //
    return response;
  }
}
