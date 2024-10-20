abstract class BackgroundUploadsRepository {
  //
  Future<void> startAllUploads();
  //
  Future<void> startUpload({required int operationID});
  //
  Future<void> refreshUploads();
  //
  Future<void> stopAllUploads();
  //
  Future<void> stopUpload({required int operationID});
}
