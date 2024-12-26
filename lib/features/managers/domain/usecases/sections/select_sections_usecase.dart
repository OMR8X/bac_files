import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_section_converter.dart';
import '../../../data/responses/select_entities_response.dart';
import '../../entities/file_section.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/select_entities_request.dart';

class SelectSectionsUseCase {
  ///
  final ManagersRepository repository;

  ///
  SelectSectionsUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileSection>>> call({
    required SelectEntitiesRequest request,
  }) {
    return repository.selectEntities(
      request: request,
      apiEndpoint: ApiEndpoints.sections,
      converter: FileSectionConverter(),
    );
  }
}
