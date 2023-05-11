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

class ArticleDetailCommentController extends BaseRefreshController<ArticleDetailRepository, ArticleInfoDatas>  with GetTickerProviderStateMixin {

  late String id;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments;
    initPage = Get.find<int>(tag: className(ArticleDetailCommentController));
    page = initPage;
    refreshController = Get.find(tag: className(ArticleDetailCommentController));
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
}