import 'package:logger/logger.dart';

class DebuggingFactory {
  Logger call() {
    late final Logger logger;
    logger = Logger(
      printer: PrettyPrinter(
        colors: true,
        noBoxingByDefault: true,
      ),
    );
    return logger;
  }
}
