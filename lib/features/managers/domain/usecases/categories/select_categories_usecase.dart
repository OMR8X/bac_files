import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_category_converter.dart';
import '../../../data/responses/select_entities_response.dart';
import '../../entities/file_category.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/select_entities_request.dart';

class SelectCategoriesUseCase {
  ///
  final ManagersRepository repository;

  ///
  SelectCategoriesUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileCategory>>> call({
    required SelectEntitiesRequest request,
  }) {
    return repository.selectEntities(
      apiEndpoint: ApiEndpoints.categories,
      request: request,
      converter: FileCategoryConverter(),
    );
  }
}
