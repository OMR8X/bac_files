import 'package:bac_files_admin/features/managers/data/converters/file_material_converter.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../../../core/services/api/api_constants.dart';
import '../../../data/responses/create_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/create_entity_request.dart';

class CreateMaterialUseCase {
  ///
  final ManagersRepository repository;

  ///
  CreateMaterialUseCase({required this.repository});

  Future<Either<Failure, CreateEntityResponse>> call({
    required CreateEntityRequest<FileMaterial> request,
  }) {
    return repository.createEntity<FileMaterial>(
      apiEndpoint: ApiEndpoints.materials,
      request: request,
      converter: FileMaterialConverter(),
    );
  }
}
