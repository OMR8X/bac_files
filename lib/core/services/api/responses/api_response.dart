import 'package:bac_files_admin/core/resources/errors/exceptions.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  //
  final bool? status;
  //
  final int? statusCode;
  //
  final String message;
  // hold incoming data from response
  final List<dynamic> data;
  // hold any errors details
  final Map<String, dynamic>? errors;
  //
  final int? currentPage;
  final int? lastPage;

  ApiResponse({
    required this.status,
    required this.statusCode,
    required this.errors,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  void throwErrorIfExists() {
    if (status == false || (errors?.isNotEmpty ?? false)) {
      throw ServerException(message: message);
    }

    if (statusCode != 200 || statusCode != 201) {
      if (errors != null && errors != {}) {
        throw ServerException(message: message);
      }
      return;
    }

    throw const ServerException();
  }

  dynamic getData({dynamic key}) {
    if (key != null) {
      return data[key];
    }
    return data;
  }

  String getMessage() {
    //
    String details = message;
    //
    if (errors != null || errors != {}) {
      //
      details += ' : \n';
      //
      (errors ?? {}).forEach((key, value) {
        details += (value as List).first;
      });
      //
    }
    //
    return details;
  }

  factory ApiResponse.fromDioResponse(Response response) {
    return ApiResponse(
      data: response.data["data"] ?? [],
      status: response.data["status"] as bool?,
      statusCode: response.statusCode,
      errors: response.data["errors"],
      message: response.data["message"] ?? "",
      currentPage: response.data["current_page"] ?? 0,
      lastPage: response.data["last_page"] ?? 0,
    );
  }
}
