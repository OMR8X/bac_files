import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../entities/operation.dart';
import '../entities/operation_type.dart';
import '../repositories/operations_repository.dart';

class GetAllOperationsUseCase {
  final OperationsRepository repository;
  GetAllOperationsUseCase({required this.repository});
  Future<Either<Failure, List<Operation>>> call({required OperationType type}) async {
    return await repository.getAllOperations(type: type);
  }
}
