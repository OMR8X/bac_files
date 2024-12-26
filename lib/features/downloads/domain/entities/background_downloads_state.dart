import 'package:bac_files_admin/features/downloads/domain/usecases/start_downloads_usecase.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/background_uploads_state.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../files/domain/requests/download_file_request.dart';
import '../../../operations/domain/entities/operation.dart';

class BackgroundDownloadsState {
  //
  bool isDownloading = false;
  bool isRefreshing = false;
  List<DownloadFileRequest> requests = List.empty(growable: true);
  DownloadFileRequest? currentRequest;

  // start download
  startDownloads() async {
    //
    if (isDownloading) {
      return;
    }
    //
    isDownloading = true;
    await _processNextDownload();
    //
    isDownloading = false;
    isRefreshing = false;
    //
    if (sl<BackgroundDownloadsState>().requests.isEmpty) {
      if (sl<BackgroundUploadsState>().requests.isEmpty) {
        sl<ServiceInstance>().stopSelf();
      }
    }
  }

  _processNextDownload() async {
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
      var response = await sl<StartDownloadUsecase>().call(
        request: currentRequest!,
      );
      //
      await _processNextDownload();
      //
    } on Exception {
      await _processNextDownload();
    }
  }

  // stop download
  cancelCurrentDownloading() {
    try {
      isDownloading = false;
      currentRequest?.cancelToken.cancel();
    } on Exception {}
  }

  setDownloads({required List<Operation> operations}) async {
    requests = operations.map((e) {
      return DownloadFileRequest.fromOperation(e);
    }).toList();
  }

  addDownloads({required List<Operation> operations}) async {
    //
    requests.addAll(operations.map((e) => DownloadFileRequest.fromOperation(e)).toList());
    //
    if (!isDownloading) {
      startDownloads();
    }
  }

  removeDownloads({required List<int> ids}) async {
    for (var id in ids) {
      requests.removeWhere((e) => e.operation.id == id);
      //
      if (currentRequest?.operation.id == id) {
        cancelCurrentDownloading();
      }
    }
  }

  removeAllDownloads() async {
    //
    requests.removeWhere((e) => true);
    //
    cancelCurrentDownloading();
  }
}
