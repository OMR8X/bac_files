import 'package:bac_files_admin/features/files/domain/requests/upload_file_request.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';
import 'package:bac_files_admin/features/uploads/domain/usecases/start_uploads_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../core/services/debug/debugging_manager.dart';
import '../../../downloads/domain/entities/background_downloads_state.dart';
import '../../../downloads/domain/repositories/background_downloads_messenger_repository.dart';
import '../../../operations/domain/entities/operation.dart';

class BackgroundUploadsState {
  //
  bool isUploading = false;
  bool isRefreshing = false;
  List<UploadFileRequest> requests = List.empty(growable: true);
  UploadFileRequest? currentRequest;

  // start upload
  startUploads() async {
    if (isUploading) {
      return;
    }

    isUploading = true;
    await _processNextUpload();
    //
    isUploading = false;
    isRefreshing = false;
    //
    if (sl<BackgroundDownloadsState>().requests.isEmpty) {
      if (sl<BackgroundUploadsState>().requests.isEmpty) {
        sl<ServiceInstance>().stopSelf();
      }
    }
  }

  _processNextUpload() async {
    //
    if (requests.isEmpty) {
      return;
    }
    //
    currentRequest = requests.first;
    //
    requests.removeAt(0);
    //
    try {
      //
      var response = await sl<StartUploadUsecase>().call(
        request: currentRequest!,
      );
      //
      await _processNextUpload();
      //
    } on Exception {
      await _processNextUpload();
    }
  }

  // stop upload
  cancelCurrentUploading() {
    try {
      isUploading = false;
      currentRequest?.cancelToken.cancel();
    } on Exception {}
  }

  setUploads({required List<Operation> operations}) async {
    requests = operations.map((e) {
      return UploadFileRequest.fromOperation(e);
    }).toList();
  }

  addUploads({required List<Operation> operations}) async {
    //
    requests.addAll(operations.map((e) => UploadFileRequest.fromOperation(e)).toList());
    //
    if (!isUploading) {
      startUploads();
    }
  }

  removeUploads({required List<int> ids}) async {
    for (var id in ids) {
      requests.removeWhere((e) => e.operation.id == id);
      //
      if (currentRequest?.operation.id == id) {
        cancelCurrentUploading();
      }
    }
  }

  removeAllUploads() async {
    //
    requests.removeWhere((e) => true);
    //
    cancelCurrentUploading();
  }
}
