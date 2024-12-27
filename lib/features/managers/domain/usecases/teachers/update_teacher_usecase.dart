import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/data/mappers/teacher_mappers.dart';
import 'package:bac_files/features/managers/domain/entities/teacher.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_teacher_converter.dart';
import '../../../data/responses/update_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/update_entity_request.dart';

class UpdateTeacherUseCase {
  ///
  final ManagersRepository repository;

  ///
  UpdateTeacherUseCase({required this.repository});

  Future<Either<Failure, UpdateEntityResponse>> call({
    required UpdateEntityRequest<FileTeacher> request,
  }) {
    return repository.updateEntity(
      apiEndpoint: ApiEndpoints.teachers,
      request: request,
      converter: FileTeacherConverter(),
    );
  }
}
