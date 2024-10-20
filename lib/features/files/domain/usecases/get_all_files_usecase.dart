import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/data/converters/bac_file_converter.dart';
import 'package:bac_files_admin/features/managers/domain/repositories/managers_repository.dart';
import 'package:bac_files_admin/features/managers/domain/requests/select_entities_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../managers/data/responses/select_entities_response.dart';

class GetAllFilesUsecase {
  final ManagersRepository repository;

  GetAllFilesUsecase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<BacFile>>> call({required SelectEntitiesRequest request}) {
    return repository.selectEntities(
      apiEndpoint: ApiEndpoints.files,
      converter: BacFileConverter(),
      request: request,
    );
  }
}
