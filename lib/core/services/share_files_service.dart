import 'dart:async';

import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../injector/app_injection.dart';

class ShareFilesService {
  ///
  static initialize() {
    ///
    /// For receiving single shared files
    ReceiveSharingIntent.instance.getMediaStream().listen((List<SharedMediaFile> items) {
      debugPrint("Received shared files: ${items.length}");

      onAddFiles(items);
    }, onError: (error) {
      Fluttertoast.showToast(msg: "error : ${error.toString()}");
    });

    ///
    /// For receiving files when the app is in background or closed
    ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> items) {
      debugPrint("Received shared files when app is in background or closed: ${items.length}");

      onAddFiles(items);
    }, onError: (error) {
      Fluttertoast.showToast(msg: "error : ${error.toString()}");
    });

    ///
  }

  static onAddFiles(List<SharedMediaFile> items) async {
    for (var item in items) {
      //
      if (!item.path.endsWith('.pdf')) continue;
      //
      if (item.path.isEmpty) continue;
      //
      debugPrint("adding: ${item.path}");
      //
      sl<UploadsBloc>().add(AddSharedOperationEvent(path: item.path));
    }
  }
}
