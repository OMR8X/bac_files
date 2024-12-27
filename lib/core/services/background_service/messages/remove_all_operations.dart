import 'package:bac_files/features/operations/data/mappers/operation_type_mapper.dart';
import 'package:bac_files/features/operations/domain/entities/operation_type.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../features/downloads/domain/entities/background_downloads_state.dart';
import '../../../../features/uploads/domain/entities/background_uploads_state.dart';
import '../../../injector/app_injection.dart';
import '../background_register.dart';
import '../background_service.dart';

class RemoveAllOperationMessenger implements BackgroundRegister {
  @override
  String get channelName => 'remove_all_operation';

  ///
  @override
  void register(ServiceInstance service) {
    service.on(channelName).listen((event) async {
      response(event);
    });
  }

  ///
  @override
  Map<String, dynamic> request({required arguments}) {
    return {
      "type": (arguments as OperationType).name,
    };
  }

  ///
  @override
  void response(Map<String, dynamic>? data) {
    OperationType type = (data!['type'] as String).toOperationType;
    //
    if (type == OperationType.upload) {
      sl<BackgroundUploadsState>().removeAllUploads();
    } else {
      sl<BackgroundDownloadsState>().removeAllDownloads();
    }
  }
}
