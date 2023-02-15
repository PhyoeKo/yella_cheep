import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository.dart';
import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository_impl.dart';
import 'package:explore_places/get_x/data_sources/network/orders/order_repository.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository.dart';
import 'package:explore_places/get_x/data_sources/network/sample_feature/sample_repository_impl.dart';
import 'package:get/get.dart';

import '../../data_sources/network/orders/order_repository_impl.dart';



class RepositoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SampleRepository>(
      () => SampleRepositoryImpl(),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
    Get.lazyPut<OrderRepository>(
      () => OrderRepositoryImpl(),
      tag: (OrderRepository).toString(),
      fenix: true,
    );
    Get.lazyPut<ShopRepository>(
      () => ShopRepositoryImpl(),
      tag: (ShopRepository).toString(),
      fenix: true,
    );
  }
}
