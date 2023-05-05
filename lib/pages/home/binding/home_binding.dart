import 'package:get/get.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/home/controller/home_controller.dart';
import 'package:getx_sample/pages/home/repository/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRepository());

    Get.lazyPut(
      tag: className(HomeController),
          () => RefreshController(initialRefresh: true),
    );

    Get.lazyPut(tag: className(HomeController), () => 1);

    Get.lazyPut(() => HomeController());
  }
}