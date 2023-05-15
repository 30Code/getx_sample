import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_comment_controller.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_controller.dart';
import 'package:getx_sample/pages/common/article_detail/barrage_input.dart';
import 'package:getx_sample/pages/common/article_detail/barrage_switch.dart';
import 'package:getx_sample/pages/common/barrage/hi_barrage.dart';
import 'package:getx_sample/pages/common/h_article_card.dart';
import 'package:getx_sample/resource/constant.dart';
import 'package:getx_sample/widget/custom_top_bar.dart';
import 'package:getx_sample/widget/hi_tab.dart';
import 'package:getx_sample/widget/player/custom_video_player.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/loading.dart';
import '../../../utils/resource_manager.dart';
import '../../common/article_detail/expandable_content.dart';
import '../../common/article_detail/video_header.dart';
import '../../common/article_detail/video_toolbar.dart';
import '../../common/refresh_header_footer.dart';
import '../../common/refresh_status_view.dart';
import '../../common/status_view.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    double playerHeight = screenWidth * (9 / 16);

    // return Scaffold(
    //   body: GetBuilder<ArticleDetailController>(
    //     builder: (controller) {
    //       return SizedBox(
    //         width: double.infinity,
    //         height: double.infinity,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               CustomTopBar(
    //                 color: Colors.black,
    //                 height: playerHeight,
    //                 child: _buildVideoView(screenWidth, playerHeight),
    //               ),
    //               _buildTabBar(),
    //               _buildTabBarView(),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    return Material(
      child: StatusView<ArticleDetailController>(
        controller: controller,
        contentBuilder: (_) {
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
            _buildRightBarrageBtn(),
          ],
        ),
      ),
    );
  }

  /// 左侧tab 导航
  Widget _buildLeftTab() {
    return HiTab(
      ArticleDetailController.ad_tabs.map((tab)  => Tab(text: tab['name'],)).toList(),
      controller.tabController,
      fontSize: 14.sp,
    );
  }

  ///右侧弹幕按钮
  Widget _buildRightBarrageBtn() {
    return Obx(() {
      //弹幕开关组件
      return BarrageSwitch(
        //输入框是否显示
        onShowInput: () {
          controller.inputShowing.value = true;
          // 悬浮输入框
          HiOverlay.show(
              Get.context!,
              child: BarrageInput(
                //关闭
                onTabClose: () {
                  controller.inputShowing.value = false;
                },
              ),).then((value) {
                Loading.toast(value.toString());
              },
          );
        },
        //弹幕功能开关回调
        onBarrageSwitch: (open) {
          Loading.toast(open.toString());
        },
        //正在输入弹幕
        inputShowing: controller.inputShowing.value,
      );
    });
  }

  /// 构建内容
  _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: ArticleDetailController.ad_tabs.map((tab) {
          if (tab['name'] == "简介") {
            return _buildInfo();
          } else {
            return _buildComment();
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
          if (controller.data?[0] != null) ..._buildMenu(),
          if (controller.data?[0] != null) ..._buildVideoList(),
        ],
      ),
    );
  }

  ///评论列表
  Widget _buildComment() {
    final commentController = Get.find<ArticleDetailCommentController>();
    return Scaffold(
      body: RefreshStatusView<ArticleDetailCommentController>(
        controller: commentController,
        contentBuilder: (controller) {
          return SmartRefresher(
            enablePullUp: true,
            header: const RefreshHeader(),
            footer: const RefreshFooter(),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
            child: ListView.builder(
              itemCount: controller.dataSource.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.dataSource[index];
                return _buildCommentItem(model);
              },
            ),
          );
        },
      ),
    );
  }

  /// 视频基础信息
  List<Widget> _buildMenu() {
    var videoInfo = controller.data![0];
    return [
      VideoHeader(videoInfo),
      ExpandableContent(videoInfo: videoInfo),
      //支持点赞和收藏
      ViewToolBar(
        videoDetailMo: videoInfo,
        onLike: controller.likeClick,
        onUnLike: controller.unlikeClick,
        onFavorite: controller.favoriteClick,
      ),
    ];
  }

  ///视频列表
  List<Widget> _buildVideoList() {
    var videoList = controller.data!;
    return videoList.map((video) => HArticleCard(
      model: video,
      callback: (_) {

      },
    ),).toList();
  }

  /// 视频播放
  Widget _buildVideoView(double screenWidth, double playerHeight) {
    var videoInfo = controller.data?[0];
    if (videoInfo?.link != null) {
      return CustomVideoPlayer(
        url: "https://media.w3.org/2010/05/sintel/trailer.mp4",
        barrageUI: HiBarrage(
          vid: "test123",
          autoPlay: true,
          headers: Constant.barrageHeaders(),
        ),
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

  ///评论Item
  Widget _buildCommentItem(ArticleInfoDatas model) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15,).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15).r,
            child: Image.asset(ImageHelper.wrapAssets("app_logo.png"), width: 30.w, height: 30.h, fit: BoxFit.cover,),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15).r,
                  child: Text(model.chapterName!),
                ),
                ExpandableContent(videoInfo: model),
              ],
            ),
          ),
        ],
      ),
    );
  }
}