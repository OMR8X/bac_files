import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../repositories/operations_repository.dart';

class UpdateOperationUseCase {
  final OperationsRepository repository;
  UpdateOperationUseCase({required this.repository});
  Future<Either<Failure, Unit>> call({required UploadOperation operation}) async {
    return await repository.updateOperation(operation: operation);
  }
}
