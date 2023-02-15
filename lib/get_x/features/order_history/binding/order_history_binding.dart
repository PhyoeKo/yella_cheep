import 'package:get/get.dart';
import 'package:yella_merchant/core/binding/view_controller_binding.dart';
import 'package:yella_merchant/data_sources/network/orders/order_repository.dart';
import 'package:yella_merchant/features/order_history/controller/order_history_controller.dart';

class OrderHistoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistoryController(findInject(OrderRepository)));
  }

}