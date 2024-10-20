import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:dio/dio.dart';

class UploadFileRequest {
  final UploadOperation operation;
  final CancelToken cancelToken;
  final void Function(int sent, int total) onSendProgress;

  UploadFileRequest({
    required this.operation,
    required this.cancelToken,
    required this.onSendProgress,
  });

  UploadFileRequest copyWith({
    UploadOperation? operation,
    CancelToken? cancelToken,
    void Function(int sent, int total)? onSendProgress,
  }) {
    return UploadFileRequest(
      operation: operation ?? this.operation,
      cancelToken: cancelToken ?? this.cancelToken,
      onSendProgress: onSendProgress ?? this.onSendProgress,
    );
  }

  factory UploadFileRequest.fromOperation(UploadOperation operation) {
    return UploadFileRequest(
      operation: operation,
      cancelToken: CancelToken(),
      onSendProgress: (sent, total) {},
    );
  }
}
