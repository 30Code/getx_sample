import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/refresh_header_footer.dart';
import 'package:getx_sample/pages/common/refresh_status_view.dart';
import 'package:getx_sample/pages/home/controller/home_controller.dart';
import 'package:getx_sample/pages/my/controller/my_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../logger/logger.dart';
import '../../../routes/routes.dart';
import '../../common/info_cell.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    myController.autoLogin();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("首页"),
          trailing: IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () => {},
          ),
        ),
        child: RefreshStatusView(
          controller: controller,
          contentBuilder: (_) {
            return SmartRefresher(
              enablePullUp: true,
              header: const RefreshHeader(),
              footer: const RefreshFooter(),
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoadMore,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: Swiper(
                        itemBuilder: (BuildContext itemContext, int index) {
                          if (controller.banners.length >= index) {
                            return CachedNetworkImage(
                              fit: BoxFit.fitWidth,
                              imageUrl: controller.banners[index].imagePath,
                              placeholder: (context, url) => Image.asset(
                                "assets/images/bg_image_loading.png",
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        itemCount: controller.banners.length,
                        pagination: const SwiperPagination(),
                        autoplay: controller.swiperAutoPlay.value,
                        autoplayDisableOnInteraction: true,
                        onTap: (index) {
                          logger.d(index);
                          // Get.toNamed("/web/true",
                          //     arguments: controller.banners[index]);
                        },
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final model = controller.dataSource[index];
                          return InfoCell(
                            model: model,
                            callback: (_) async {
                              Get.toNamed(Routes.web, arguments: model);
                              },
                          );
                        },
                        childCount: controller.dataSource.length,
                      ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}