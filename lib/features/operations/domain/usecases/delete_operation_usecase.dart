import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../repositories/operations_repository.dart';

class DeleteOperationUseCase {
  final OperationsRepository repository;
  DeleteOperationUseCase({required this.repository});
  Future<Either<Failure, Operation>> call({required int operationId}) async {
    return await repository.deleteOperation(operationId: operationId);
  }
}