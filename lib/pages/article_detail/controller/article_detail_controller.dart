import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/base/base_refresh_controller.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/enum/response_status.dart';
import 'package:getx_sample/enum/scroll_view_action_type.dart';
import 'package:getx_sample/logger/class_name.dart';
import 'package:getx_sample/pages/article_detail/repository/article_detail_repository.dart';
import 'package:getx_sample/utils/view_utils.dart';

import '../../../entity/base_entity.dart';

class ArticleDetailController extends BaseRefreshController<ArticleDetailRepository, ArticleInfoDatas>  with GetTickerProviderStateMixin {
  static const ad_tabs = [
    {"key": "introduce", "name": "简介"},
    {"key": "comment", "name": "评论"},
  ];

  late TabController tabController;

  List<ArticleInfoDatas> listIntroduce = [];

  late String id;

  @override
  void onInit() {
    super.onInit();
    setStatusBarColor(statusStyle: StatusStyle.LIGHT_CONTENT);
    tabController = TabController(length: ad_tabs.length, vsync: this);

    id = Get.arguments;
    initPage = Get.find<int>(tag: className(ArticleDetailController));
    page = initPage;
    refreshController = Get.find(tag: className(ArticleDetailController));
  }

  @override
  void onReady() async {
    super.onReady();
    var listIntroduceEntity = await request.getArticleDetailInfo().catchError((error) {
      status = ResponseStatus.fail;
      update();
    }) as BaseEntity<List<ArticleInfoDatas>>;

    listIntroduce = listIntroduceEntity.data!;

    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
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
    response = await request.getCommentList(page: page, id: id).catchError((error) {
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

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}