import 'dart:convert';
import 'dart:io';

import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/errors/exceptions.dart';
import '../../../../core/services/api/responses/api_response.dart';
import '../../domain/requests/upload_file_request.dart';
import '../responses/upload_file_response.dart';

abstract class FilesRemoteDataSource {
  Future<UploadFileResponse> uploadFile({required UploadFileRequest request});
}

class FilesRemoteDataSourceImplements implements FilesRemoteDataSource {
  final ApiManager _manager;

  FilesRemoteDataSourceImplements({required ApiManager manager}) : _manager = manager;
  @override
  Future<UploadFileResponse> uploadFile({required UploadFileRequest request}) async {
    //
    if (!(await File(request.operation.path).exists())) throw const FileNotExistsException();
    //
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.operation.path,
        filename: request.operation.path.split("/").last,
      ),
      'title': request.operation.file.title,
      'size': request.operation.file.size,
      'extension': request.operation.file.extension,
      'year': request.operation.file.year,
      'section_id': request.operation.file.sectionId,
      'material_id': request.operation.file.materialId,
      'teacher_id': request.operation.file.teacherId,
      'school_id': request.operation.file.schoolId,
      'categories_ids[]': request.operation.file.categoriesIds.toList(),
    });

    /// Prepare the headers
    final headers = {
      "Content-Type": "multipart/form-data",
    };

    ///
    final dioResponse = await _manager().post(
      ApiEndpoints.files,
      body: formData,
      responseType: ResponseType.json,
      headers: headers,
      cancelToken: request.cancelToken,
      onSendProgress: request.onSendProgress,
    );

    ///
    ApiResponse apiResponse = ApiResponse.fromDioResponse(dioResponse);

    ///
    apiResponse.throwErrorIfExists();

    ///
    final response = UploadFileResponse.fromApiResponse(response: apiResponse);

    ///
    return response;
  }
}
