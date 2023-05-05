import 'package:getx_sample/base/base_refresh_controller.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/enum/scroll_view_action_type.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/pages/project/repository/article_list_repository.dart';

import '../../../enum/response_status.dart';

class ArticleListController extends BaseRefreshController<ArticleListRepository, ArticleInfoDatas> {

  late TagType tagType;

  late String id;

  @override
  Future<void> onRefresh() async {
    page = initPage;
    await asyncRequest(type: ScrollViewActionType.refresh);
  }

  @override
  Future<void> onLoadMore() async {
    page = page + 1;
    await asyncRequest(type: ScrollViewActionType.loadMore);
  }

  @override
  Future<void> asyncRequest({required ScrollViewActionType type, Map<String, dynamic>? parameters}) async {
    response = await request.getListArticle(page: page, id: id, tagType: tagType).catchError((error) {
      return processError(type: type, error: error);
    });
    status = response?.responseStatus ?? ResponseStatus.loading;

    final models = response?.data?.dataSource ?? [];

    switch (type) {
      case ScrollViewActionType.refresh:
        dataSource.clear();
        dataSource.addAll(models);
        break;
      case ScrollViewActionType.loadMore:
        dataSource.addAll(models);
        break;
    }

    refreshControllerStatusUpdate(type);

    update();
  }

}