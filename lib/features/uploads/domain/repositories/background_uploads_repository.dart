import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../files/data/responses/upload_file_response.dart';
import '../../../files/domain/requests/upload_file_request.dart';

abstract class BackgroundUploadsRepository {
  Future<Either<Failure, UploadFileResponse>> startUpload({required UploadFileRequest request});
}
