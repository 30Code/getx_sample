import 'package:get/get.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/pages/project/controller/project_controller.dart';
import 'package:getx_sample/pages/project/repository/project_repository.dart';
import 'package:getx_sample/pages/project/repository/article_list_repository.dart';

class ProjectBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ProjectRepository(TagType.project),);
    Get.lazyPut(() => ProjectController(TagType.project));
    Get.lazyPut(() => ArticleListRepository());
  }

}