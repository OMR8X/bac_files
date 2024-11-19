import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../files/data/responses/upload_file_response.dart';

class BackgroundUploadsState {
  //
  bool isUploading = false;
  bool isRefreshing = false;
  bool canUpload = true;
  List<UploadFileRequest> requests = List.empty(growable: true);
  UploadFileRequest? currentRequest;
  //

  // start upload
  startUploads({
    required Future<Either<Failure, UploadFileResponse>> Function({required UploadFileRequest request}) onUploadFiles,
  }) async {
    //
    sl<DebuggingManager>()().logMessage("starting uploads , length is : ${requests.length}");
    //
    canUpload = true;
    //
    if (isUploading) return;
    //
    isUploading = true;
    //
    while (requests.isNotEmpty && canUpload) {
      //
      sl<DebuggingManager>()().logMessage("refreshing an upload..");

      ///
      currentRequest = requests.firstOrNull;

      /// check if there is a request
      if (currentRequest == null) continue;

      /// start uploading
      try {
        await onUploadFiles(request: currentRequest!).then((value) {
          value.fold((l) {
            if (requests.isNotEmpty) {
              requests.removeAt(0);
            }
          }, (r) {
            if (requests.isNotEmpty) {
              if (requests.isNotEmpty) {
                requests.removeAt(0);
              }
            }
          });
        });
      } on Exception catch (e) {
        continue;
      }
      //
      await Future.delayed(const Duration(seconds: 1));
      //
    }
    //
    isUploading = false;
    //
    isRefreshing = false;
  }

  //
  // stop upload
  stopUploading() {
    debugPrint("stopUploading in state");
    try {
      isUploading = false;
      canUpload = false;
      currentRequest?.cancelToken.cancel();
    } on Exception {}
  }

  //
  // refresh uploads
  refreshUploads({required List<UploadFileRequest> requests}) async {
    ///
    debugPrint("can refreshUploads in state ? $isRefreshing");

    ///
    if (isRefreshing) return;

    ///
    debugPrint("start refreshUploads in state");

    ///
    isRefreshing = true;

    ///
    this.requests.removeWhere((e) => true);

    ///
    this.requests.addAll(requests);

    ///
    sl<DebuggingManager>()().logMessage("refreshing uploads, length is : ${requests.length}");

    ///
    isRefreshing = false;
  }
}
