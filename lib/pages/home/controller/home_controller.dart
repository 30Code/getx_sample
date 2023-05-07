import '../../../base/base_request_controller.dart';
import '../../../entity/tab_entity.dart';
import '../../../enum/response_status.dart';
import '../../../enum/tag_type.dart';
import '../repository/home_repository.dart';

class HomeController extends BaseRequestController<HomeRepository, List<TabEntity>> {
  HomeController(this.type);

  TagType type;

  @override
  void onInit() async {
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
    if (data!.isNotEmpty) {
      if (data![0].id == 408) {
        data![0].name = "推荐";
      }
    }
    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
  }
}