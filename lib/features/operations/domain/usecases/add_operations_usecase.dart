import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../repositories/operations_repository.dart';

class AddOperationsUseCase {
  final OperationsRepository repository;
  AddOperationsUseCase({required this.repository});
  Future<Either<Failure, List<Operation>>> call({required List<Operation> operations}) async {
    return await repository.addOperations(operations: operations);
  }
}
