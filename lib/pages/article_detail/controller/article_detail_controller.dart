import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/base/base_request_controller.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/enum/response_status.dart';
import 'package:getx_sample/pages/article_detail/repository/article_detail_repository.dart';
import 'package:getx_sample/utils/view_utils.dart';

import '../../../utils/loading.dart';

class ArticleDetailController extends BaseRequestController<ArticleDetailRepository, List<ArticleInfoDatas>>  with GetTickerProviderStateMixin {
  static const ad_tabs = [
    {"key": "introduce", "name": "简介"},
    {"key": "comment", "name": "评论"},
  ];

  late TabController tabController;

  //是否正在输入弹幕
  var inputShowing = false.obs;

  @override
  void onInit() {
    super.onInit();
    setStatusBarColor(statusStyle: StatusStyle.LIGHT_CONTENT);
    tabController = TabController(length: ad_tabs.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    asyncRequest();
  }

  @override
  Future<void> asyncRequest({Map<String, dynamic>? parameters}) async {
    response = await request.getArticleDetailInfo().catchError((error) {
      status = ResponseStatus.fail;
      update();
      return error;
    });
    data = response?.data ?? [];
    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
  }

  /// 点赞
  void likeClick() async {
    Loading.toast("暂不支持该功能!");
  }

  /// 取消点赞
  void unlikeClick() {
    Loading.toast("暂不支持该功能!");
  }

  /// 收藏取消收藏
  void favoriteClick() {
    Loading.toast("暂不支持该功能!");
  }

  @override
  void onClose() {
    setStatusBarColor(statusStyle: StatusStyle.DARK_CONTENT);
    tabController.dispose();
    super.onClose();
  }
}