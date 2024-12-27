import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/responses/delete_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/delete_entity_request.dart';

class DeleteMaterialUseCase {
  ///
  final ManagersRepository repository;

  ///
  DeleteMaterialUseCase({required this.repository});

  Future<Either<Failure, DeleteEntityResponse>> call({
    required DeleteEntityRequest request,
  }) {
    return repository.deleteEntity(
      request: request,
      apiEndpoint: ApiEndpoints.materials,
    );
  }
}
