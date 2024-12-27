import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/data/converters/file_category_converter.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/responses/create_entity_response.dart';
import '../../entities/file_category.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/create_entity_request.dart';

class CreateCategoryUseCase {
  ///
  final ManagersRepository repository;

  ///
  CreateCategoryUseCase({required this.repository});

  Future<Either<Failure, CreateEntityResponse>> call({
    required CreateEntityRequest<FileCategory> request,
  }) {
    return repository.createEntity<FileCategory>(
      converter: FileCategoryConverter(),
      apiEndpoint: ApiEndpoints.categories,
      request: request,
    );
  }
}
