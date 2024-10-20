import 'package:bac_files_admin/core/services/debug/debugging_factory.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;

abstract class DebuggingClient {
  void initialize();
  void logMessage(String message);
  void logError(String message);
  void logWarning(String message);
  void logDebug(String message);
  void logVerbose(String message);
}

class LoggerClient implements DebuggingClient {
  late final Logger _logger;

  @override
  initialize() {
    _logger = DebuggingFactory().call();
  }

  @override
  void logMessage(String message) {
    developer.log(message);
  }

  @override
  void logError(String message) {
    developer.log(message);
  }

  @override
  void logWarning(String message) {
    developer.log(message);
  }

  @override
  void logDebug(String message) {
    //
    developer.log(message);
  }

  @override
  void logVerbose(String message) {
    developer.log(message);
  }
}
