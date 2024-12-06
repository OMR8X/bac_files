import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../files/data/responses/download_file_response.dart';
import '../../../files/domain/requests/download_file_request.dart';
import '../repositories/background_downloads_repository.dart';

class StartDownloadUsecase {
  final BackgroundDownloadsRepository repository;

  StartDownloadUsecase({
    required this.repository,
  });

  Future<Either<Failure, DownloadFileResponse>> call({required DownloadFileRequest request}) async {
    return await repository.startDownload(request: request);
  }
}
