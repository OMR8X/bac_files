import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';

import '../../data/responses/upload_file_response.dart';

abstract class FilesRepository {
  Future<Either<Failure, UploadFileResponse>> uploadFile({
    required UploadFileRequest request,
  });
}
