import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/domain/repositories/managers_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../managers/data/responses/delete_entity_response.dart';
import '../../../managers/domain/requests/delete_entity_request.dart';

class DeleteFileUsecase {
  final ManagersRepository repository;

  DeleteFileUsecase({required this.repository});

  Future<Either<Failure, DeleteEntityResponse>> call({required DeleteEntityRequest request}) {
    return repository.deleteEntity(
      apiEndpoint: ApiEndpoints.files,
      request: request,
    );
  }
}
