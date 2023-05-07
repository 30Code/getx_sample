import 'package:get/get.dart';
import 'package:getx_sample/base/base_refresh_controller.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/entity/banner_entity.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/entity/page_entity.dart';
import 'package:getx_sample/enum/response_status.dart';
import 'package:getx_sample/enum/scroll_view_action_type.dart';
import 'package:getx_sample/logger/logger.dart';
import 'package:getx_sample/pages/home/repository/recommend_repository.dart';

import '../../../logger/class_name.dart';

class RecommendController extends BaseRefreshController<RecommendRepository, ArticleInfoDatas> {
  List<BannerEntity> banners = [];

  var swiperAutoPlay = false.obs;

  @override
  void onInit() {
    super.onInit();
    initPage = Get.find<int>(tag: className(RecommendController));
    page = initPage;
    refreshController = Get.find(tag: className(RecommendController));
  }

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
    response = await request.getArticleList(page: page).catchError((error) {
      return processError(type: type, error: error);
    });

    status = response?.responseStatus ?? ResponseStatus.loading;

    final models = response?.data?.dataSource ?? [];

    switch (type) {
      case ScrollViewActionType.refresh:
        final result = await Future.wait([
          request.getBanner(),
          request.getTopArticleList(),
          request.getArticleList(page: page),
        ], cleanUp: (successValue) => logger.d(successValue),);

        if (result.length == 3) {
          final bannerModels = result[0].data as List<BannerEntity>;
          final topArticleModels = result[1].data as List<ArticleInfoDatas>;
          response = result[2] as BaseEntity<PageEntity<List<ArticleInfoDatas>>>;
          final articleModels = response?.data?.dataSource ?? [];

          banners = bannerModels;
          swiperAutoPlay.value = true;

          dataSource = topArticleModels;
          dataSource.addAll(articleModels);
        } else {
          response = BaseEntity(null, null, null);
          swiperAutoPlay.value = false;
        }
        break;
      case ScrollViewActionType.loadMore:
        response = await request.getArticleList(page: page);
        dataSource.addAll(models);
        break;
    }
    refreshControllerStatusUpdate(type);
    update();
  }
}