import 'dart:io';
import 'dart:typed_data';

import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/resources/errors/exceptions.dart';
import '../../../../core/services/api/responses/api_response.dart';
import '../../domain/requests/download_file_request.dart';
import '../../domain/requests/upload_file_request.dart';

import '../responses/download_file_response.dart';
import '../responses/upload_file_response.dart';

abstract class FilesRemoteDataSource {
  Future<UploadFileResponse> uploadFile({required UploadFileRequest request});
  Future<DownloadFileResponse> downloadFile({required DownloadFileRequest request});
}

class FilesRemoteDataSourceImplements implements FilesRemoteDataSource {
  final ApiManager _manager;

  FilesRemoteDataSourceImplements({required ApiManager manager}) : _manager = manager;
  @override
  Future<UploadFileResponse> uploadFile({required UploadFileRequest request}) async {
    //
    if (!(await File(request.operation.path).exists())) {
      throw const FileNotExistsException();
    }
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
    //
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

  @override
  Future<DownloadFileResponse> downloadFile({required DownloadFileRequest request}) async {
    ///
    /// Prepare file
    File file = File(request.operation.path);

    /// Calculate file local bytes length
    int localBytesLength = 0;
    int fullLength = 0;
    //
    // Ensure the file exists
    if (!await file.exists()) {
      await file.create();
    }

    if (await file.exists()) {
      localBytesLength = await file.length();
      fullLength += localBytesLength;
    }

    ///
    /// Prepare RandomAccessFile
    final randomAccessFile = file.openSync(mode: FileMode.append);

    ///
    /// prepare headers
    Map<String, dynamic>? headers = {};

    /// check if file contain previous data
    if (localBytesLength != 0) {
      headers = {HttpHeaders.rangeHeader: "bytes=$localBytesLength-"};
    }
    //
    /// prepare http connection
    Response response = await _manager().get(
      ApiEndpoints.downloadFile(request.operation.file.id),
      headers: headers,
      responseType: ResponseType.stream,
      cancelToken: request.cancelToken,
    );

    /// get file full length
    int contentLength = int.parse(
      response.headers.value(HttpHeaders.contentLengthHeader) ?? '0',
    );

    fullLength += contentLength;

    /// prepare stream
    final stream = (response.data.stream as Stream<Uint8List>);

    ///

    final subscription = stream.listen(
      (chunk) {
        /// Write bytes to file
        randomAccessFile.writeFromSync(chunk);

        /// Update localBytesLength
        localBytesLength += chunk.length;
        //

        request.onSendProgress(localBytesLength, fullLength);
      },
    );

    ///
    // Cancel the subscription if the token is cancelled
    request.cancelToken.whenCancel.then((_) {
      subscription.cancel();
    });

    ///
    await subscription.asFuture();

    ///
    await randomAccessFile.close();

    ///
    return DownloadFileResponse();
  }
}
