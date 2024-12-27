import 'dart:async';

import 'package:bac_files/presentation/uploads/state/uploads/uploads_bloc.dart';
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
      onAddFiles(items);
    }, onError: (error) {
      Fluttertoast.showToast(msg: "error : ${error.toString()}");
    });

    ///
    /// For receiving files when the app is in background or closed
    ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> items) {
      onAddFiles(items);
    }, onError: (error) {
      Fluttertoast.showToast(msg: "error : ${error.toString()}");
    });

    ///
  }

  static onAddFiles(List<SharedMediaFile> items) async {
    sl<UploadsBloc>().add(AddSharedOperationEvent(
      paths: items.where((item) => item.path.endsWith('.pdf') && item.path.isNotEmpty).map((e) => e.path).toList(),
    ));
  }
}
