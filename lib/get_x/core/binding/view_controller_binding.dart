import 'package:explore_places/get_x/features/sample_feature/binding/sample_binding.dart';
import 'package:get/get.dart';


class ViewControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SampleBinding>(
          () => SampleBinding(),
    );
  }

}

T findInject<T>(T) => Get.find(tag: (T).toString());
