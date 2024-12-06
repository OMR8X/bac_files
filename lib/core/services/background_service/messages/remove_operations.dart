import 'package:bac_files_admin/core/services/background_service/background_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../features/downloads/domain/entities/background_downloads_state.dart';
import '../../../../features/uploads/domain/entities/background_uploads_state.dart';
import '../../../injector/app_injection.dart';
import '../background_register.dart';

class RemoveOperationMessenger implements BackgroundRegister {
  @override
  String channelName = 'remove_operation';

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
      "ids": arguments as List<int>,
    };
  }

  ///
  @override
  void response(Map<String, dynamic>? data) {
    //
    List<int> ids = (data?["ids"] as List? ?? []).cast<int>();
    //

    //
    sl<BackgroundUploadsState>().removeUploads(ids: ids);
    //
    sl<BackgroundDownloadsState>().removeDownloads(ids: ids);
  }
}
