import 'dart:io';

import 'package:bac_files/core/resources/errors/exceptions.dart';
import 'package:bac_files/core/resources/errors/failures.dart';
import 'package:bac_files/features/files/data/datasources/files_remote_datasource.dart';
import 'package:bac_files/features/files/data/responses/upload_file_response.dart';
import 'package:bac_files/features/files/domain/requests/download_file_request.dart';
import 'package:bac_files/features/files/domain/requests/upload_file_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/files_repository.dart';
import '../responses/download_file_response.dart';

class FilesRepositoryImplement implements FilesRepository {
  final FilesRemoteDataSource _remoteDataSource;

  FilesRepositoryImplement({
    required FilesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, UploadFileResponse>> uploadFile({required UploadFileRequest request}) async {
    try {
      debugPrint("error: start");
      final response = await _remoteDataSource.uploadFile(request: request);
      debugPrint("error: no error");
      return right(response);
    } on Exception catch (e) {
      //
      late final Failure failure;
      //
      if (e is PathNotFoundException) {
        failure = FileNotExistsFailure(message: e.toString());
      }
      //
      else if (e is DioException) {
        if (e.type == DioExceptionType.cancel) {
          failure = (CanceledFailure(message: e.message));
        } else {
          failure = (AnonFailure(message: e.message));
        }
      }
      //
      else if (e is ServerException) {
        failure = (AnonFailure(message: e.message));
      }
      //
      else {
        failure = (AnonFailure(message: e.toString()));
      }
      debugPrint("error: $e");

      return left(failure);
    }
  }

  @override
  Future<Either<Failure, DownloadFileResponse>> downloadFile({required DownloadFileRequest request}) async {
    try {
      final response = await _remoteDataSource.downloadFile(request: request);
      return right(response);
    } on Exception catch (e) {
      //
      late final Failure failure;
      //
      if (e is PathNotFoundException) {
        failure = FileNotExistsFailure(message: e.toString());
      }
      //
      else if (e is DioException) {
        if (e.type == DioExceptionType.cancel) {
          failure = (CanceledFailure(message: e.message));
        } else {
          failure = (AnonFailure(message: e.message));
        }
      }
      //
      else if (e is ServerException) {
        failure = (AnonFailure(message: e.message));
      }
      //
      else {
        failure = (AnonFailure(message: e.toString()));
      }
      //
      return left(failure);
    }
  }
}
