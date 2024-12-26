import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_category_converter.dart';
import '../../../data/responses/update_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/update_entity_request.dart';

class UpdateCategoryUseCase {
  ///
  final ManagersRepository repository;

  ///
  UpdateCategoryUseCase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({
    required UpdateEntityRequest<FileCategory> request,
  }) {
    return repository.updateEntity(
      request: request,
      apiEndpoint: ApiEndpoints.categories,
      converter: FileCategoryConverter(),
    );
  }
}
