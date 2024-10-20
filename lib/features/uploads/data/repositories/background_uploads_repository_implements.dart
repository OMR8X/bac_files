import 'dart:async';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/features/uploads/data/datasources/background_uploads_data_source.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/background_uploads_state.dart';
import 'package:bac_files_admin/features/uploads/domain/repositories/background_uploads_repository.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/services/cache/cache_manager.dart';
import '../../../files/domain/requests/upload_file_request.dart';

class BackgroundUploadsRepositoryImplements implements BackgroundUploadsRepository {
  //
  //
  final CacheManager _cacheManager;

  //
  final BackgroundUploadsDataSource _backgroundUploadsDataSource;
  late final ServiceInstance backgroundService;

  BackgroundUploadsRepositoryImplements({required BackgroundUploadsDataSource backgroundUploadsDataSource, required CacheManager cacheManager})
      : _backgroundUploadsDataSource = backgroundUploadsDataSource,
        _cacheManager = cacheManager;

  @override
  Future<void> refreshUploads() async {
    //
    final List<UploadFileRequest> requests = await _backgroundUploadsDataSource.getPendingUploads();
    //
    sl<BackgroundUploadsState>().refreshUploads(
      requests: requests,
    );
    //
    sl<BackgroundUploadsState>().startUploads(
      onUploadFiles: _backgroundUploadsDataSource.startRequest,
    );
    return;
  }

  @override
  Future<void> startAllUploads() async {
    //
    await _backgroundUploadsDataSource.startAllUploads();
    await refreshUploads();
    return;
  }

  @override
  Future<void> startUpload({required int operationID}) async {
    //
    await _backgroundUploadsDataSource.startUpload(operationID: operationID);
    await refreshUploads();
    return;
  }

  @override
  Future<void> stopAllUploads() async {
    //
    sl<DebuggingManager>()().logMessage("3- Stopping all uploads in background ");
    //
    sl<BackgroundUploadsState>().refreshUploads(requests: []);
    sl<BackgroundUploadsState>().stopUploading();
    //
    await _backgroundUploadsDataSource.stopAllUploads();
    // await refreshUploads();
    return;
  }

  @override
  Future<void> stopUpload({required int operationID}) async {
    //
    if (sl<BackgroundUploadsState>().currentRequest?.operation.id == operationID) {
      sl<BackgroundUploadsState>().refreshUploads(requests: []);
      sl<BackgroundUploadsState>().stopUploading();
    }
    //
    await _backgroundUploadsDataSource.stopUpload(operationID: operationID);
    await refreshUploads();
    //
    return;
  }
}
