import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';

abstract class BackgroundMessengerRepository {
  //
  Future<void> sendUpdateState({List<UploadOperation>? operations});
  //
  Future<void> sendOperationFailed({required int id, required String title});
  //
  Future<void> sendOperationCompletedMessage({required int id, required String title});
  //
  Future<void> sendProgressMessageMessage({
    required int id,
    required String title,
    required int sent,
    required int total,
  });
}
