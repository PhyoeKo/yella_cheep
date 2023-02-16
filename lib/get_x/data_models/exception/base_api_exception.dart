

import 'package:explore_places/get_x/data_models/exception/app_exception.dart';

abstract class BaseApiException extends AppException {
  final int httpCode;
  final String status;

  BaseApiException({
    this.httpCode = -1,
    this.status = "",
    String message = "",
  }) : super(message: message);
}
