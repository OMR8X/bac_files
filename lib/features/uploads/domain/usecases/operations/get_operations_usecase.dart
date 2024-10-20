import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../entities/upload_operation.dart';
import '../../repositories/operations_repository.dart';

class GetAllOperationsUseCase {
  final OperationsRepository repository;
  GetAllOperationsUseCase({required this.repository});
  Future<Either<Failure, List<UploadOperation>>> call() async {
    return await repository.getAllOperations();
  }
}
