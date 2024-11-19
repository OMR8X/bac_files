import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../entities/operation_state.dart';
import '../../entities/upload_operation.dart';
import '../../repositories/operations_repository.dart';

class UpdateAllOperationsStateUseCase {
  final OperationsRepository repository;
  UpdateAllOperationsStateUseCase({required this.repository});
  Future<Either<Failure, List<UploadOperation>>> call({required OperationState state}) async {
    return await repository.updateAllOperationsState(state: state);
  }
}
