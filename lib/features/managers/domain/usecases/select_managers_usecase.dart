import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/data/converters/file_managers_converter.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:bac_files/features/managers/domain/repositories/managers_repository.dart';
import 'package:bac_files/features/managers/domain/requests/select_entities_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/select_entities_response.dart';

class SelectManagersUseCase {
  final ManagersRepository repository;

  SelectManagersUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileManagers>>> call() {
    return repository.selectEntities<FileManagers>(
      apiEndpoint: ApiEndpoints.managers,
      converter: FileManagersConverter(),
      request: SelectEntitiesRequest(),
    );
  }
}
