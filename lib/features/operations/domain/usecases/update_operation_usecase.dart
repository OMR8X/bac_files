import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../repositories/operations_repository.dart';

class UpdateOperationUseCase {
  final OperationsRepository repository;
  UpdateOperationUseCase({required this.repository});
  Future<Either<Failure, List<Operation>>> call({required Operation operation}) async {
    return await repository.updateOperation(operation: operation);
  }
}
