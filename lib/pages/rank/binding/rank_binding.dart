import 'package:get/get.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/rank/controller/rank_controller.dart';
import 'package:getx_sample/pages/rank/repository/rank_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => RankRepository(),);

    Get.lazyPut(tag: className(RankController), () => RefreshController(initialRefresh: true),);

    Get.lazyPut<int>(tag: className(RankController), () => 1,);

    Get.lazyPut(() => RankController(),);
  }

}