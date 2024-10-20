import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';

class StopAllUploadsUsecase {
  final BackgroundUploadsRepository repository;

  StopAllUploadsUsecase({
    required this.repository,
  });

  Future<void> call() async {
    return await repository.stopAllUploads();
  }
}
