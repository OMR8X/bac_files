import 'package:bac_files/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/upload_file_response.dart';
import '../repositories/files_repository.dart';

class UploadFileUsecase {
  final FilesRepository repository;

  UploadFileUsecase({required this.repository});

  Future<Either<Failure, UploadFileResponse>> call({required UploadFileRequest request}) {
    return repository.uploadFile(request: request);
  }
}
