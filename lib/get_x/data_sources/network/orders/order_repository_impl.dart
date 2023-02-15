import 'package:dio/dio.dart';
import 'package:yella_merchant/core/base/base_remote_source.dart';
import 'package:yella_merchant/core/services/dio_provider.dart';
import 'package:yella_merchant/data_models/base_response/base_api_response.dart';
import 'package:yella_merchant/data_models/pagination/pagination_ob.dart';
import 'package:yella_merchant/data_models/responses/order_history_response.dart';
import 'package:yella_merchant/data_sources/network/orders/order_repository.dart';

class OrderRepositoryImpl extends BaseRemoteSource implements OrderRepository {
  var endpoint = DioProvider.baseUrl;

  //Get Order List
  @override
  Future<BaseApiResponse<OrderHistoryResponse>> getOrderList({
    int? offset = 10,
    required int shopId,
    required String? orderStatus,
    int? categoryId,
    String? fromDate,
    String? toDate,
  }) {
    var dioCall = dioClient.get(
        "$endpoint/api/order-history?offset=$offset&shopId=$shopId&status=${1}&categoryId=0&fromDate=${fromDate ?? ""}&toDate=${toDate ?? ""}");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseOrderListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<OrderHistoryResponse> _parseOrderListResponse(
      Response response) {
    return BaseApiResponse<OrderHistoryResponse>.fromListJsonWithPagination(
        response.data,
        create: (data) => OrderHistoryResponse.fromJson(data),
        createLinkObject: (linkData) => Links.fromJson(linkData),
        createMetaObject: (metaData) => Meta.fromJson(metaData));
  }

  @override
  Future<BaseApiResponse<String?>> createInvoice(
      {required int shopId, required String? qrCodr, price}) {
    var dioCall = dioClient.get(
        "$endpoint/api/order-qr-scan?shopId=$shopId&qrCode=$qrCodr&price=$price");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _phaseCreateVoucherResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<String?> _phaseCreateVoucherResponse(Response response) {
    return BaseApiResponse<String?>.fromStringJson(
      response.data,
    );
  }
}
