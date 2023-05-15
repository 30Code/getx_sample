import 'package:get/get.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_comment_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleDetailCommentBinding extends Bindings {

  @override
  void dependencies() {
    // Get.lazyPut(() => ArticleDetailRepository(),);

    Get.lazyPut(tag: className(ArticleDetailCommentController), () => RefreshController(initialRefresh: true),);

    Get.lazyPut(tag: className(ArticleDetailCommentController), () => 1);

    Get.lazyPut(() => ArticleDetailCommentController(),);
  }

}