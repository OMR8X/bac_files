abstract class BackgroundMessengerRepository {
  //
  Future<void> sendUpdateState();
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
