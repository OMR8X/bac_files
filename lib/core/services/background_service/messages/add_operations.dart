import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/features/operations/data/mappers/operation_mapper.dart';
import 'package:bac_files/features/operations/data/models/operation_model.dart';
import 'package:bac_files/features/operations/domain/entities/operation_type.dart';
import 'package:bac_files/features/uploads/domain/entities/background_uploads_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../features/downloads/domain/entities/background_downloads_state.dart';
import '../../../../features/operations/domain/entities/operation.dart';
import '../background_register.dart';
import '../background_service.dart';

class AddOperationsMessenger implements BackgroundRegister {
  @override
  String get channelName => 'add_operation';

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
      "operations": (arguments as List<Operation>).map((e) => e.toModel.toJson()).toList(),
    };
  }

  ///
  @override
  response(Map<String, dynamic>? data) {
    //
    List jsonList = data?["operations"] ?? [];
    //
    final operations = jsonList.map((e) {
      return OperationModel.fromJson(e);
    }).toList();
    //

    //
    if (operations.first.type == OperationType.upload) {
      sl<BackgroundUploadsState>().addUploads(operations: operations);
    } else {
      sl<BackgroundDownloadsState>().addDownloads(operations: operations);
    }
  }
}
