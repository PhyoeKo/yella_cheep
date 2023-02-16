import 'dart:io';

import 'package:explore_places/get_x/data_models/exception/api_exception.dart';



class NotFoundException extends ApiException {
  NotFoundException(String message, String status)
      : super(httpCode: HttpStatus.notFound, status: status, message: message);
}
