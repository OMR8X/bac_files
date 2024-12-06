import 'package:flutter_background_service/flutter_background_service.dart';

// BackgroundMessanger
abstract class BackgroundMessanger {
  //
  Future<void> sendOperationFailedMessage({required String fileId, required String message});
  //
  Future<void> sendOperationCompletedMessage({required String fileId});
  //
  Future<void> sendProgressMessage({required String fileId, required int sent, required int total});
}

class BackgroundMessangerImplements implements BackgroundMessanger {
  final ServiceInstance _backgroundService;

  BackgroundMessangerImplements({
    required ServiceInstance backgroundService,
  }) : _backgroundService = backgroundService;
  @override
  Future<void> sendOperationCompletedMessage({required String fileId}) async {
    _backgroundService.invoke("on-completed", {
      "file_id": fileId,
      "status": true,
    });
  }

  @override
  Future<void> sendOperationFailedMessage({required String fileId, required String message}) async {
    _backgroundService.invoke("on-failed", {
      "file_id": fileId,
      "status": false,
      "message": message,
    });
  }

  @override
  Future<void> sendProgressMessage({String? fileId, String? operationId, required int sent, required int total}) async {
    _backgroundService.invoke("on-progress", {
      "file_id": fileId,
      "operation_id": operationId,
      "sent": sent,
      "total": total,
    });
  }
}
