import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/article_detail/controller/article_detail_controller.dart';
import 'package:getx_sample/widget/custom_top_bar.dart';
import 'package:getx_sample/widget/hi_tab.dart';

import '../../common/refresh_status_view.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {

  ArticleDetailPage({Key? key}) : super(key: key);

  final _articleDetailController = Get.find<ArticleDetailController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtil().screenWidth;
    double playerHeight = screenWidth * (9 / 16);
    return Material(
      child: RefreshStatusView<ArticleDetailController>(
        controller: _articleDetailController, 
        contentBuilder: (_) {
          return Column(
            children: [
              CustomTopBar(
                color: Colors.black,
                height: playerHeight,
                child: _buildVideoView(screenWidth, playerHeight),
              ),
              _buildTabBar(),
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
            return Container();
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }

  /// 视频播放
  Widget _buildVideoView(double screenWidth, double playerHeight) {
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