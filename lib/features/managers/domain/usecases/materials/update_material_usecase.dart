import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/data/mappers/material_mappers.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_material_converter.dart';
import '../../../data/responses/update_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/update_entity_request.dart';

class UpdateMaterialUseCase {
  ///
  final ManagersRepository repository;

  ///
  UpdateMaterialUseCase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({
    required UpdateEntityRequest<FileMaterial> request,
  }) {
    return repository.updateEntity(
      apiEndpoint: ApiEndpoints.materials,
      request: request,
      converter: FileMaterialConverter(),
    );
  }
}