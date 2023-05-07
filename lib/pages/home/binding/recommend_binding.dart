import 'package:get/get.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/home/controller/recommend_controller.dart';
import 'package:getx_sample/pages/home/repository/recommend_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendRepository());

    Get.lazyPut(
      tag: className(RecommendController),
          () => RefreshController(initialRefresh: true),
    );

    Get.lazyPut(tag: className(RecommendController), () => 1);

    Get.lazyPut(() => RecommendController());
  }
}