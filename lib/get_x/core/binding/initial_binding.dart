
import 'package:explore_places/get_x/core/binding/cached_manager_binding.dart';
import 'package:explore_places/get_x/core/binding/repository_binding.dart';
import 'package:explore_places/get_x/core/binding/view_controller_binding.dart';
import 'package:get/get.dart';


import 'remote_source_bindings.dart';class InitialBinding implements Bindings {
  @override
  void dependencies() {
    CachedManagerBinding().dependencies();
    RepositoryBinding().dependencies();
    RemoteSourceBindings().dependencies();
    ViewControllerBinding().dependencies();
  }
}
