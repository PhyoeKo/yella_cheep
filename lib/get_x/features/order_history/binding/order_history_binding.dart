import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:explore_places/get_x/data_sources/network/orders/order_repository.dart';
import 'package:explore_places/get_x/features/order_history/controller/order_history_controller.dart';
import 'package:get/get.dart';

class OrderHistoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OrderHistoryController(findInject(OrderRepository)));
  }

}