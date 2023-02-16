import 'dart:io';

import 'package:explore_places/get_x/data_models/exception/base_api_exception.dart';



class UnauthorizedException extends BaseApiException {
  UnauthorizedException(String message)
      : super(
          httpCode: HttpStatus.unauthorized,
          message: message,
          status: "unauthorized",
        );
}
