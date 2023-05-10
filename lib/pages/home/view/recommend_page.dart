import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/refresh_header_footer.dart';
import 'package:getx_sample/pages/common/refresh_status_view.dart';
import 'package:getx_sample/pages/home/controller/recommend_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../entity/banner_entity.dart';
import '../../../resource/colors.dart';
import '../../../routes/routes.dart';
import '../../common/article_card.dart';
import '../../common/recommend_banner.dart';

class RecommendPage extends GetView<RecommendController> {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final myController = Get.find<MyController>();
    // myController.autoLogin();

    return GetBuilder<RecommendController>(
      builder: ((controller) {
        return Container(
          color: ColorRes.color_F5F5F9,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SmartRefresher(
              enablePullUp: true,
              header: const RefreshHeader(),
              footer: const RefreshFooter(),
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoadMore,
              child: CustomScrollView(
                cacheExtent: 700,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _buildBanner(controller.banners),
                  ),
                  //瀑布流
                  SliverMasonryGrid.count(
                      childCount: controller.dataSource.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.h,
                      crossAxisSpacing: 5.w,
                      itemBuilder: (context, index) {
                        return _buildArticleCard(index);
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// banner
  Widget _buildBanner(List<BannerEntity> bannerList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: RecommendBanner(
        bannerList,
        bannerHeight: 177.h,
      ),
    );
  }

  Widget _buildArticleCard(int index) {
    final model = controller.dataSource[index];
    return ArticleCard(model: model, callback: (_) async {
      Get.toNamed(Routes.articleDetail, arguments: "402");
    },);
  }
}