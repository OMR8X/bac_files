import 'package:bac_files/core/services/api/api_constants.dart';
import 'package:bac_files/features/managers/data/models/file_teacher_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../../data/converters/file_teacher_converter.dart';
import '../../../data/responses/select_entities_response.dart';
import '../../entities/teacher.dart';
import '../../repositories/managers_repository.dart';
import '../../requests/select_entities_request.dart';

class SelectTeachersUseCase {
  ///
  final ManagersRepository repository;

  ///
  SelectTeachersUseCase({required this.repository});

  Future<Either<Failure, SelectEntitiesResponse<FileTeacher>>> call({
    required SelectEntitiesRequest request,
  }) {
    return repository.selectEntities(
      request: request,
      apiEndpoint: ApiEndpoints.teachers,
      converter: FileTeacherConverter(),
    );
  }
}
