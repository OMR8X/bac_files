import 'package:bac_files_admin/features/managers/data/converters/file_section_converter.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_section.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../../../core/services/api/api_constants.dart';
import '../../../data/responses/create_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/create_entity_request.dart';

class CreateSectionUseCase {
  ///
  final ManagersRepository repository;

  ///
  CreateSectionUseCase({required this.repository});

  Future<Either<Failure, CreateEntityResponse>> call({
    required CreateEntityRequest<FileSection> request,
  }) {
    return repository.createEntity<FileSection>(
      apiEndpoint: ApiEndpoints.sections,
      request: request,
      converter: FileSectionConverter(),
    );
  }
}
