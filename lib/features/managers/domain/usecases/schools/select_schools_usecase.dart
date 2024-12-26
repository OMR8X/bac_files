import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_school_converter.dart';
import '../../../data/responses/select_entities_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/select_entities_request.dart';

class SelectSchoolsUseCase {
  ///
  final ManagersRepository repository;

  ///
  SelectSchoolsUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileSchool>>> call({
    required SelectEntitiesRequest request,
  }) {
    return repository.selectEntities(
      request: request,
      apiEndpoint: ApiEndpoints.schools,
      converter: FileSchoolConverter(),
    );
  }
}
