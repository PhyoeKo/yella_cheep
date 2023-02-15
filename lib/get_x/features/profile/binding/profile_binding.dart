import 'package:get/get.dart';
import 'package:yella_merchant/data_sources/network/profile/profile_repository.dart';
import 'package:yella_merchant/data_sources/network/profile/profile_repository_impl.dart';
import 'package:yella_merchant/features/profile/controller/profile_controller.dart';

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