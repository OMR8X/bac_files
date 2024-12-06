
import 'package:dio/dio.dart';

import '../../../operations/domain/entities/operation.dart';

class DownloadFileRequest {

  final Operation operation;
  final CancelToken cancelToken;
  final void Function(int sent, int total) onSendProgress;

  DownloadFileRequest({
    required this.operation,
    required this.cancelToken,
    required this.onSendProgress,
  });

  DownloadFileRequest copyWith({
    Operation? operation,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onSendProgress,
  }) {
    return DownloadFileRequest(
      operation: operation ?? this.operation,
      cancelToken: cancelToken ?? this.cancelToken,
      onSendProgress: onSendProgress ?? this.onSendProgress,
    );
  }

  factory DownloadFileRequest.fromOperation(Operation operation) {
    return DownloadFileRequest(
      operation: operation,
      cancelToken: CancelToken(),
      onSendProgress: (sent, total) {},
    );
  }
}
