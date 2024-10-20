import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/data/converters/bac_file_converter.dart';
import 'package:bac_files_admin/features/managers/domain/repositories/managers_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../managers/data/responses/select_entity_response.dart';
import '../../../managers/domain/requests/select_entity_request.dart';

class GetFileUsecase {
  final ManagersRepository repository;

  GetFileUsecase({required this.repository});

  Future<Either<Failure, SelectEntityResponse<BacFile>>> call({required SelectEntityRequest request}) {
    return repository.selectEntity(
      apiEndpoint: ApiEndpoints.files,
      converter: BacFileConverter(),
      request: request,
    );
  }
}
