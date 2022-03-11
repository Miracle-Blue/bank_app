import 'package:logger/logger.dart';
import 'retro_fit_service.dart';

class Log {
  static final Logger _logger = Logger(printer: PrettyPrinter());

  static void d(String message) {
    if (isTester) _logger.d(message);
  }

  static void i(String message) {
    if (isTester) _logger.i(message);
  }

  static void w(String message) {
    if (isTester) _logger.w(message);
  }

  static void e(String message) {
    if (isTester) _logger.e(message);
  }
}