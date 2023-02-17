import 'package:explore_places/get_x/data_sources/network/profile/profile_repository.dart';
import 'package:explore_places/get_x/data_sources/network/profile/profile_repository_impl.dart';
import 'package:explore_places/get_x/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut<ProfileRepository>(
          () => ProfileRepositoryImpl(),
      tag: (ProfileRepository).toString(),
    );
  }

}