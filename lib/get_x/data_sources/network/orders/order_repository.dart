
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/request_ob/login_request_ob.dart';
import 'package:yella_merchant/data_models/responses/login_response.dart';
import 'package:yella_merchant/data_models/responses/order_history_response.dart';

import '../../../data_models/request_ob/firebase_token_request_ob.dart';

abstract class OrderRepository {

  Future<BaseApiResponse<OrderHistoryResponse>> getOrderList({
    int? offset,
    required int shopId,
    required String? orderStatus,
    int? categoryId,
    String? fromDate,
    String? toDate,
  });

  Future<BaseApiResponse<String?>> createInvoice({
    required int shopId,
    required String? qrCodr,
    var price,

  });
}
