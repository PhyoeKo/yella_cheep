import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository.dart';
import 'package:explore_places/get_x/data_sources/network/authentication/auth_repository_impl.dart';
import 'package:get/get.dart';



class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
  }
}
