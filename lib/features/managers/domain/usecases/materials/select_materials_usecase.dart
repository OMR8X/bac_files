import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/data/models/file_material_model.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_material_converter.dart';
import '../../../data/responses/select_entities_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/select_entities_request.dart';

class SelectMaterialsUseCase {
  ///
  final ManagersRepository repository;

  ///
  SelectMaterialsUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileMaterial>>> call({
    required SelectEntitiesRequest request,
  }) {
    return repository.selectEntities(
      request: request,
      converter: FileMaterialConverter(),
      apiEndpoint: ApiEndpoints.materials,
    );
  }
}
