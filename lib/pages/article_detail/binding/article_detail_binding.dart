import 'package:get/get.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_controller.dart';
import 'package:getx_sample/pages/article_detail/repository/article_detail_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleDetailBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailRepository(),);

    Get.lazyPut(tag: className(ArticleDetailController), () => RefreshController(initialRefresh: true),);

    Get.lazyPut(tag: className(ArticleDetailController), () => 1);

    Get.lazyPut(() => ArticleDetailController(),);
  }

}