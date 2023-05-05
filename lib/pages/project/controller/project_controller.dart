import 'package:getx_sample/base/base_request_controller.dart';
import 'package:getx_sample/entity/tab_entity.dart';
import 'package:getx_sample/enum/response_status.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/pages/project/repository/project_repository.dart';

class ProjectController extends BaseRequestController<ProjectRepository, List<TabEntity>> {

  TagType type;

  ProjectController(this.type);

  @override
  void onInit() {
    super.onInit();
    asyncRequest();
  }

  @override
  Future<void> asyncRequest({Map<String, dynamic>? parameters}) async {
    response = await request.getTab().catchError((error) {
      status = ResponseStatus.fail;
      update();
      return error;
    });
    data = response?.data ?? [];
    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
  }

}