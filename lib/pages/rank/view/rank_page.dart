import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/pages/rank/controller/rank_controller.dart';
import 'package:getx_sample/utils/view_utils.dart';
import 'package:getx_sample/widget/custom_top_bar.dart';
import 'package:getx_sample/widget/hi_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../widget/keep_alive_wrapper.dart';
import '../controller/rank_tab_controller.dart';
import 'rank_tab_page.dart';

class RankPage extends GetView<RankController> {

  late RankController rankController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankController>(
      builder: (controller) {
        rankController = controller;
        return Column(
          children: <Widget>[
            CustomTopBar(
              child: Container(
                decoration: bottomBoxShadow(context),
                alignment: Alignment.center,
                child: _tabBar(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: RankController.tabs.map((tab) {

                  String id = "294";
                  if (tab['key'] == "like") {
                    id = "294";
                  } else if (tab['key'] == "pubdate") {
                    id = "402";
                  } else if (tab['key'] == "favorite") {
                    id = "367";
                  }

                  final tabController = RankTabController();
                  tabController.tagType = TagType.project;
                  tabController.id = id;
                  tabController.request = Get.find();
                  tabController.refreshController = RefreshController(initialRefresh: true);
                  tabController.page = TagType.project.pageNum;
                  tabController.initPage = TagType.project.pageNum;
                  Get.put(tabController, tag: id);

                  return KeepAliveWrapper(
                    child: RankTabPage(
                      controller: tabController,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tabBar() {
    return HiTab(
      RankController.tabs.map((tab) => Tab(text: tab['name'],)).toList(),
      rankController.tabController, fontSize: 14.sp, borderWidth: 3.h,
    );
  }
}