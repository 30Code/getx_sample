import 'package:get/get.dart';

import '../../../enum/tag_type.dart';
import '../../project/repository/article_list_repository.dart';
import '../controller/home_controller.dart';
import '../repository/home_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => HomeRepository(TagType.publicNumber),
    );

    Get.lazyPut(
          () => HomeController(TagType.publicNumber),
    );

    Get.lazyPut(() => ArticleListRepository(),);
  }
}