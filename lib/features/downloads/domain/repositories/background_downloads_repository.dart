import 'package:bac_files/features/files/data/responses/download_file_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../files/domain/requests/download_file_request.dart';

abstract class BackgroundDownloadsRepository {
  Future<Either<Failure, DownloadFileResponse>> startDownload({required DownloadFileRequest request});
}
