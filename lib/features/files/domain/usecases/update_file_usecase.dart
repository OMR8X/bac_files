import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/files/domain/entities/bac_file.dart';
import 'package:bac_files/features/managers/data/converters/bac_file_converter.dart';
import 'package:bac_files/features/managers/domain/repositories/managers_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../managers/data/responses/update_entity_response.dart';
import '../../../managers/domain/requests/update_entity_request.dart';

class UpdateFileUsecase {
  final ManagersRepository repository;

  UpdateFileUsecase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({required UpdateEntityRequest<BacFile> request}) {
    return repository.updateEntity(
      apiEndpoint: ApiEndpoints.files,
      converter: BacFileConverter(),
      request: request,
    );
  }
}
