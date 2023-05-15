import 'package:get/get.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_controller.dart';
import 'package:getx_sample/pages/article_detail/repository/article_detail_repository.dart';

class ArticleDetailBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailRepository(),);

    Get.lazyPut(() => ArticleDetailController(),);
  }

}