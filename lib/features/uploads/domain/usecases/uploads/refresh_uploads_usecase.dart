import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';

class RefreshUploadsUsecase {
  final BackgroundUploadsRepository repository;

  RefreshUploadsUsecase({
    required this.repository,
  });

  Future<void> call() async {
    return await repository.refreshUploads();
  }
}
