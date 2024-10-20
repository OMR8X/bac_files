import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';

class StartUploadUsecase {
  final BackgroundUploadsRepository repository;

  StartUploadUsecase({
    required this.repository,
  });

  Future<void> call({required int operationID}) async {
    return await repository.startUpload(operationID: operationID);
  }
}
