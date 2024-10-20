import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';

class StartAllUploadsUsecase {
  final BackgroundUploadsRepository repository;

  StartAllUploadsUsecase({
    required this.repository,
  });

  Future<void> call() async {
    return await repository.startAllUploads();
  }
}
