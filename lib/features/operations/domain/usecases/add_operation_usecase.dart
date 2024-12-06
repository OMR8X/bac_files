import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../repositories/operations_repository.dart';

class AddOperationUseCase {
  final OperationsRepository repository;
  AddOperationUseCase({required this.repository});
  Future<Either<Failure, Operation>> call({required Operation operation}) async {
    return await repository.addOperation(operation: operation);
  }
}
