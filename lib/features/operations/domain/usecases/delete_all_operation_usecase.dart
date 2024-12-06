import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../entities/operation_type.dart';
import '../repositories/operations_repository.dart';

class DeleteAllOperationUseCase {
  final OperationsRepository repository;
  DeleteAllOperationUseCase({required this.repository});
  Future<Either<Failure, List<Operation>>> call({required OperationType type}) async {
    return await repository.deleteAllOperations(type: type);
  }
}
