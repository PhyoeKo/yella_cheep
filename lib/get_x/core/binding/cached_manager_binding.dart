import 'package:explore_places/get_x/data_sources/local/cache_manager.dart';
import 'package:get/get.dart';


class CachedManagerBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<CacheManager>(
      () => CacheManager(),
      tag: (CacheManager).toString(),
    );

  }
}
