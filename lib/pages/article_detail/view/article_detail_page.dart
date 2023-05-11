import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_controller.dart';
import 'package:getx_sample/pages/common/h_article_card.dart';
import 'package:getx_sample/widget/custom_top_bar.dart';
import 'package:getx_sample/widget/hi_tab.dart';
import 'package:getx_sample/widget/player/custom_video_player.dart';

import '../../common/article_detail/expandable_content.dart';
import '../../common/article_detail/video_header.dart';
import '../../common/article_detail/video_toolbar.dart';
import '../../common/refresh_status_view.dart';
import '../../common/status_view.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {

  late ArticleDetailController _articleDetailController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    double playerHeight = screenWidth * (9 / 16);
    return Material(
      child: StatusView<ArticleDetailController>(
        controller: controller,
        contentBuilder: (_) {
          _articleDetailController = controller;
          return Column(
            children: [
              CustomTopBar(
                color: Colors.black,
                height: playerHeight,
                child: _buildVideoView(screenWidth, playerHeight),
              ),
              _buildTabBar(),
              _buildTabBarView(),
            ],
          );
        },
      ),
    );
  }

  /// 简介和评论
  Widget _buildTabBar() {
    //Material 实现阴影效果
    return Material(
      elevation: 0.3,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.w),
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeftTab(),
          ],
        ),
      ),
    );
  }

  /// 左侧tab 导航
  Widget _buildLeftTab() {
    return HiTab(
      ArticleDetailController.ad_tabs.map((tab)  => Tab(text: tab['name'],)).toList(),
      _articleDetailController.tabController,
      fontSize: 14.sp,
    );
  }

  /// 构建内容
  _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _articleDetailController.tabController,
        children: ArticleDetailController.ad_tabs.map((tab) {
          if (tab['name'] == "简介") {
            return _buildInfo();
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }

  /// 推荐视频列表
  Widget _buildInfo() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(0).r,
        children: [
          if (_articleDetailController.data?[0] != null) ..._buildMenu(),
          if (_articleDetailController.data?[0] != null) ..._buildVideoList(),
        ],
      ),
    );
  }

  /// 视频基础信息
  List<Widget> _buildMenu() {
    var videoInfo = _articleDetailController.data![0];
    return [
      VideoHeader(videoInfo),
      ExpandableContent(videoInfo: videoInfo),
      //支持点赞和收藏
      ViewToolBar(
        videoDetailMo: videoInfo,
        onLike: _articleDetailController.likeClick,
        onUnLike: _articleDetailController.unlikeClick,
        onFavorite: _articleDetailController.favoriteClick,
      ),
    ];
  }

  ///视频列表
  List<Widget> _buildVideoList() {
    var videoList = _articleDetailController.data!;
    return videoList.map((video) => HArticleCard(
      model: video,
      callback: (_) {

      },
    ),).toList();
  }

  /// 视频播放
  Widget _buildVideoView(double screenWidth, double playerHeight) {
    var videoInfo = _articleDetailController.data?[0];
    if (videoInfo?.link != null) {
      return CustomVideoPlayer(
        url: "https://media.w3.org/2010/05/sintel/trailer.mp4",

      );
    } else {
      return Container(
        alignment: Alignment.center,
        color: Colors.black,
        width: screenWidth,
        height: playerHeight,
        child: const Text(
          "正在获取视频数据...",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}