import 'package:bac_files/features/operations/domain/entities/operation.dart';
import 'package:bac_files/features/operations/domain/entities/operation_state.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/resources/errors/failures.dart';
import '../entities/operation_type.dart';
import '../repositories/operations_repository.dart';

class UpdateAllOperationsStateUseCase {
  final OperationsRepository repository;
  UpdateAllOperationsStateUseCase({required this.repository});
  Future<Either<Failure, List<Operation>>> call({required OperationState state, required OperationType type}) async {
    return await repository.updateAllOperationsState(state: state, type: type);
  }
}
