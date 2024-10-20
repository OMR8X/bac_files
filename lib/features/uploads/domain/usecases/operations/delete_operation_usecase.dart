import 'package:bac_files_admin/features/uploads/domain/repositories/operations_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';

class DeleteOperationUseCase {
  final OperationsRepository repository;
  DeleteOperationUseCase({required this.repository});
  Future<Either<Failure, Unit>> call({required int operationId}) async {
    return await repository.deleteOperations(operationId: operationId);
  }
}
