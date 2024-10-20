import 'package:dio/dio.dart';

import '../tokens/tokens_manager.dart';
import 'api_constants.dart';
import 'dio_factory.dart';

abstract class ApiClient {
  /// get request
  Future<dynamic> get(
    String uri, {
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  });

  /// post request
  Future<dynamic> post(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  });

  /// update request
  Future<dynamic> put(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  });

  /// delete request
  Future<dynamic> delete(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  });
}

class DioClient implements ApiClient {
  //
  late final DioFactory _dioFactory;
  late final Map<String, String> defaultHeaders;
  late final BaseOptions options;
  //
  DioClient() {
    //
    _dioFactory = DioFactory();
    //
    defaultHeaders = {
      ApiHeaders.headerContentTypeKey: ApiHeaders.headerContentTypeJson,
      ApiHeaders.headerAcceptKey: ApiHeaders.headerContentTypeJson,
    };
    //
    options = BaseOptions(
      headers: defaultHeaders,
      baseUrl: ApiSettings.baseUrl,
      receiveTimeout: const Duration(seconds: ApiSettings.receiveTimeout),
      sendTimeout: const Duration(seconds: ApiSettings.sendTimeout),
      connectTimeout: const Duration(seconds: ApiSettings.connectTimeout),
    
      validateStatus: (status) {
        return true;
      },
    );
  }
  //

  @override
  Future<Response> get(
    String uri, {
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  }) async {
    final dio = _getDio(
      sendAuth: requireAuth,
      headers: headers,
      params: queryParameters,
      responseType: responseType,
    );
    final response = await dio.get(uri);
    return response;
  }

  @override
  Future<Response> post(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    final dio = _getDio(
      sendAuth: requireAuth,
      headers: headers,
      params: queryParameters,
      responseType: responseType,
    );
    final response = await dio.post(
      uri,
      data: body,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
    return response;
  }

  @override
  Future<Response> put(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  }) async {
    final dio = _getDio(
      sendAuth: requireAuth,
      headers: headers,
      params: queryParameters,
      responseType: responseType,
    );
    final response = await dio.put(uri, data: body);
    return response;
  }

  @override
  Future<Response> delete(
    String uri, {
    Object? body,
    bool requireAuth = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic> queryParameters = const {},
    ResponseType? responseType,
    CancelToken? cancelToken,
  }) async {
    final dio = _getDio(
      sendAuth: requireAuth,
      headers: headers,
      params: queryParameters,
      responseType: responseType,
    );
    final response = await dio.delete(uri, data: body);
    return response;
  }

  Dio _getDio({
    required bool sendAuth,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    ResponseType? responseType,
  }) {
    //
    final Dio dio = _dioFactory();
    //
    options.headers = headers ?? defaultHeaders;
    //
    options.headers[ApiHeaders.headerAcceptKey] = ApiHeaders.headerContentTypeJson;
    //
    if (sendAuth) {
      final token = TokenManager.instance.token;
      options.headers[ApiHeaders.headerAuthorizationKey] = "Bearer $token";
    }
    // set passed parameters
    options.queryParameters = params ?? {};
    //
    dio.options = options.copyWith(responseType: responseType);
    //
    return dio;
  }
}
