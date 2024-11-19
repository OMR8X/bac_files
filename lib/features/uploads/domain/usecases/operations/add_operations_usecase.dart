import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../repositories/operations_repository.dart';

class AddOperationsUseCase {
  final OperationsRepository repository;
  AddOperationsUseCase({required this.repository});
  Future<Either<Failure, List<UploadOperation>>> call({required List<UploadOperation> operations}) async {
    return await repository.addOperations(operations: operations);
  }
}
