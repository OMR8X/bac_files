import 'package:bac_files_admin/features/uploads/domain/repositories/operations_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/resources/errors/failures.dart';
import '../../entities/upload_operation.dart';

class DeleteAllOperationUseCase {
  final OperationsRepository repository;
  DeleteAllOperationUseCase({required this.repository});
  Future<Either<Failure, List<UploadOperation>>> call() async {
    return await repository.deleteAllOperations();
  }
}
