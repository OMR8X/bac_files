import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/features/managers/data/converters/file_teacher_converter.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/responses/create_entity_response.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/create_entity_request.dart';

class CreateTeacherUseCase {
  ///
  final ManagersRepository repository;

  ///
  CreateTeacherUseCase({required this.repository});

  Future<Either<Failure, CreateEntityResponse>> call({
    required CreateEntityRequest<FileTeacher> request,
  }) {
    return repository.createEntity<FileTeacher>(
      apiEndpoint: ApiEndpoints.teachers,
      request: request,
      converter: FileTeacherConverter(),
    );
  }
}
