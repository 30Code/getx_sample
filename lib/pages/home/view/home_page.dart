import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/pages/home/controller/home_controller.dart';
import 'package:getx_sample/pages/home/view/home_tab_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../enum/scroll_view_action_type.dart';
import '../../../logger/logger.dart';
import '../../../resource/colors.dart';
import '../../../resource/res.dart';
import '../../../widget/custom_top_bar.dart';
import '../../../widget/hi_tab.dart';
import '../../../widget/keep_alive_wrapper.dart';
import '../../common/status_view.dart';
import '../../project/view/article_list_page.dart';
import '../controller/home_tab_controller.dart';
import 'recommend_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _homeController = Get.find<HomeController>();

  final _alreadyRequestIndex = <int>{};

  final List<HomeTabController> _articleListControllers = [];

  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StatusView<HomeController>(
        controller: _homeController,
        contentBuilder: (_) {
          _tabController = TabController(length: _homeController.data?.length ?? 0, vsync: this);
          _tabController.addListener(() {
            final index = _tabController.index;
            final value = _tabController.animation?.value;

            ///修复执行2次的BUG,增加条件
            if (index == value) {
              if (!_alreadyRequestIndex.contains(index)) {
                _alreadyRequestIndex.add(index);
                _articleListControllers[index].asyncRequest(type: ScrollViewActionType.refresh);
              } else {
                logger.d("已经包含不用请求");
              }
            }
          });
          return Container(
            child: Column(
              children: [
                _buildTop(),
                _buildTabBar(),
                _buildTabBarView(),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 顶部搜索
  Widget _buildTop() {
    return CustomTopBar(
        height: 44.h,
        color: ColorRes.color_F5F5F9,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  //  Routes.toLogin();
                },
                child: ClipRRect(
                  child: Image.asset(
                    Res.imageUserLogo,
                    height: 28.h,
                    width: 28.h,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(14.h),
                ),
              ),
              SizedBox(
                width: 21.5.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
                  height: 32.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Res.imageIcSearch,
                          width: 20.w,
                          height: 20.w,
                          color: ColorRes.color_979799),
                      Image.asset(
                        Res.imageIcQr,
                        width: 20.w,
                        height: 20.w,
                        color: ColorRes.color_979799,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 21.5.h,
              ),
            ],
          ),
        ));
  }

  /// 构建顶部indicator
  Widget _buildTabBar() {
    return Container(
        color: ColorRes.color_F5F5F9,
        child: HiTab(
          (_homeController.data ?? []).map((category) {
            return Tab(text: category.name);
          }).toList(),
          _tabController,
          fontSize: 14.sp,
          borderWidth: 3.h,
        ),
    );
  }

  /// 构建内容
  Widget _buildTabBarView() {
    return Expanded(
        child: TabBarView(
            controller: _tabController,
            children: (_homeController.data ?? []).map((category) {
              if (category.name == "推荐") {
                return const KeepAliveWrapper(
                  child: RecommendPage(),
                );
              } else {

                final tabController = HomeTabController();
                tabController.tagType = TagType.publicNumber;
                tabController.id = category.id.toString();
                tabController.request = Get.find();
                tabController.refreshController = RefreshController(initialRefresh: true);
                tabController.page = TagType.publicNumber.pageNum;
                tabController.initPage = TagType.publicNumber.pageNum;
                Get.put(tabController, tag: category.id.toString());
                _articleListControllers.add(tabController);

                return KeepAliveWrapper(
                  child: HomeTabPage(
                      controller: tabController,
                  ),
                );
              }
            }).toList()
        ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}