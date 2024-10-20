import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';

class StopUploadUsecase {
  final BackgroundUploadsRepository repository;

  StopUploadUsecase({
    required this.repository,
  });

  Future<void> call({required int operationID}) async {
    return await repository.stopUpload(operationID: operationID);
  }
}
