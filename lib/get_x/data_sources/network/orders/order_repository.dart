


import 'package:explore_places/get_x/data_models/base_response/base_api_response.dart';
import 'package:explore_places/get_x/data_models/responses/order_history_response.dart';

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
