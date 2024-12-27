import 'package:bac_files/features/uploads/domain/repositories/background_uploads_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../../../files/data/responses/upload_file_response.dart';
import '../../../files/domain/requests/upload_file_request.dart';

class StartUploadUsecase {
  final BackgroundUploadsRepository repository;

  StartUploadUsecase({
    required this.repository,
  });

  Future<Either<Failure, UploadFileResponse>> call({required UploadFileRequest request}) async {
    return await repository.startUpload(request: request);
  }
}
