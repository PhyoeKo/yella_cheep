
import 'package:yella_merchant/data_models/exception/base_exception.dart';

class TimeoutException extends BaseException {
  TimeoutException(String message) : super(message: message);
}
