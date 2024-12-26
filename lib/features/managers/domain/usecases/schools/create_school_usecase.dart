import 'package:bac_files_admin/features/managers/data/converters/file_school_converter.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../../../core/services/api/api_constants.dart';
import '../../../data/responses/create_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/create_entity_request.dart';

class CreateSchoolUseCase {
  ///
  final ManagersRepository repository;

  ///
  CreateSchoolUseCase({required this.repository});

  Future<Either<Failure, CreateEntityResponse>> call({
    required CreateEntityRequest<FileSchool> request,
  }) {
    return repository.createEntity<FileSchool>(
      apiEndpoint: ApiEndpoints.schools,
      request: request,
      converter: FileSchoolConverter(),
    );
  }
}
