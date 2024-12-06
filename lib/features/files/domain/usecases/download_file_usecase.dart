import 'package:bac_files_admin/features/files/domain/requests/download_file_request.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/download_file_response.dart';
import '../repositories/files_repository.dart';

class DownloadFileUsecase {
  final FilesRepository repository;

  DownloadFileUsecase({required this.repository});

Future<Either<Failure, DownloadFileResponse>> call({required DownloadFileRequest request}) {
    return repository.downloadFile(request: request);
  }
}
