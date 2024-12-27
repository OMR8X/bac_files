import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/files/domain/requests/download_file_request.dart';
import 'package:bac_files/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/responses/download_file_response.dart';
import '../../data/responses/upload_file_response.dart';

abstract class FilesRepository {
  Future<Either<Failure, UploadFileResponse>> uploadFile({
    required UploadFileRequest request,
  });
  Future<Either<Failure, DownloadFileResponse>> downloadFile({
    required DownloadFileRequest request,
  });
}
