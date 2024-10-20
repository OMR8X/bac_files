import 'dart:io';

import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/data/datasources/files_remote_datasource.dart';
import 'package:bac_files_admin/features/files/data/responses/upload_file_response.dart';
import 'package:bac_files_admin/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/files_repository.dart';

class FilesRepositoryImplement implements FilesRepository {
  final FilesRemoteDataSource _remoteDataSource;

  FilesRepositoryImplement({
    required FilesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, UploadFileResponse>> uploadFile({required UploadFileRequest request}) async {
    try {
      final response = await _remoteDataSource.uploadFile(request: request);
      return right(response);
    } on PathNotFoundException catch (e) {
      return left(FileNotExistsFailure(message: e.toString()));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        return left(CanceledFailure(message: e.message));
      } else {
        return left(AnonFailure(message: e.message));
      }
    } on Exception catch (e) {
      return left(AnonFailure(message: e.toString()));
    }
  }
}
