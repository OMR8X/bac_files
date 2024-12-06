
import 'package:dio/dio.dart';

import '../../../operations/domain/entities/operation.dart';

class UploadFileRequest {
  final Operation operation;
  final CancelToken cancelToken;
  final void Function(int sent, int total) onSendProgress;

  UploadFileRequest({
    required this.operation,
    required this.cancelToken,
    required this.onSendProgress,
  });

  UploadFileRequest copyWith({
    Operation? operation,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onSendProgress,
  }) {
    return UploadFileRequest(
      operation: operation ?? this.operation,
      cancelToken: cancelToken ?? this.cancelToken,
      onSendProgress: onSendProgress ?? this.onSendProgress,
    );
  }

  factory UploadFileRequest.fromOperation(Operation operation) {
    return UploadFileRequest(
      operation: operation,
      cancelToken: CancelToken(),
      onSendProgress: (sent, total) {},
    );
  }
}
