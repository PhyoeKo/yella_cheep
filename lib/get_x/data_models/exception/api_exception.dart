import 'package:explore_places/get_x/data_models/exception/base_api_exception.dart';

ort 'package:yella_merchant/data_models/exception/base_api_exception.dart';

class ApiException extends BaseApiException {
  ApiException({
    required int httpCode,
    required String status,
    String message = "",
  }) : super(httpCode: httpCode, status: status, message: message);
}
