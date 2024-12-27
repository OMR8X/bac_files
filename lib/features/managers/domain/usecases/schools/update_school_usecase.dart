import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/domain/entities/school.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_school_converter.dart';
import '../../../data/responses/update_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/update_entity_request.dart';

class UpdateSchoolUseCase {
  ///
  final ManagersRepository repository;

  ///
  UpdateSchoolUseCase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({
    required UpdateEntityRequest<FileSchool> request,
  }) {
    return repository.updateEntity(
      apiEndpoint: ApiEndpoints.schools,
      request: request,
      converter: FileSchoolConverter(),
    );
  }
}
