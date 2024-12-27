import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/domain/entities/file_section.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_section_converter.dart';
import '../../../data/responses/update_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/update_entity_request.dart';

class UpdateSectionUseCase {
  ///
  final ManagersRepository repository;

  ///
  UpdateSectionUseCase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({
    required UpdateEntityRequest<FileSection> request,
  }) {
    return repository.updateEntity(
      apiEndpoint: ApiEndpoints.sections,
      request: request,
      converter: FileSectionConverter(),
    );
  }
}
