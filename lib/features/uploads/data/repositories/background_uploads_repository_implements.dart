import 'dart:async';
import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/files/data/responses/upload_file_response.dart';
import 'package:bac_files/features/uploads/data/datasources/background_uploads_data_source.dart';
import 'package:bac_files/features/uploads/domain/repositories/background_uploads_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../../core/services/cache/cache_manager.dart';
import '../../../files/domain/requests/upload_file_request.dart';

class BackgroundUploadsRepositoryImplements implements BackgroundUploadsRepository {
  //
  final BackgroundUploadsDataSource _backgroundUploadsDataSource;
  late final ServiceInstance backgroundService;

  BackgroundUploadsRepositoryImplements({required BackgroundUploadsDataSource backgroundUploadsDataSource, required CacheManager cacheManager}) : _backgroundUploadsDataSource = backgroundUploadsDataSource;

  @override
  Future<Either<Failure, UploadFileResponse>> startUpload({required UploadFileRequest request}) async {
    try {
      final response = await _backgroundUploadsDataSource.startUpload(request: request);
      return response;
    } on Exception catch (e) {
      return left(const AnonFailure());
    }
  }
}
