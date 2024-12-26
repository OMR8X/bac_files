import 'dart:async';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/data/responses/download_file_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../../core/services/cache/cache_manager.dart';
import '../../../files/domain/requests/download_file_request.dart';
import '../../domain/repositories/background_downloads_repository.dart';
import '../datasources/background_downloads_data_source.dart';

class BackgroundDownloadsRepositoryImplements implements BackgroundDownloadsRepository {
  //
  final BackgroundDownloadsDataSource _backgroundDownloadsDataSource;
  late final ServiceInstance backgroundService;

  BackgroundDownloadsRepositoryImplements({required BackgroundDownloadsDataSource backgroundDownloadsDataSource, required CacheManager cacheManager}) : _backgroundDownloadsDataSource = backgroundDownloadsDataSource;

  @override
  Future<Either<Failure, DownloadFileResponse>> startDownload({required DownloadFileRequest request}) async {
    try {
      final response = await _backgroundDownloadsDataSource.startDownload(request: request);
      return response;
    } on Exception {
      return left(const AnonFailure());
    }
  }
}
