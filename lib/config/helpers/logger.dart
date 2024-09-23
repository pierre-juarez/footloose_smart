import 'package:footloose_tickets/config/constants/environment.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

void infoLog(String message) {
  if (Environment.development == "DEV") {
    logger.i(message, stackTrace: StackTrace.current);
  }
}

void errorLog(String message) {
  if (Environment.development == "DEV") {
    logger.e(message, stackTrace: StackTrace.current);
  }
}
