import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/refresh_header_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/routes.dart';
import '../../common/article_card.dart';
import '../controller/home_tab_controller.dart';

class HomeTabPage extends StatefulWidget {

  final HomeTabController _controller;

  const HomeTabPage({Key? key, required HomeTabController controller}) : _controller = controller, super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTabPageState();

}

class _HomeTabPageState extends State<HomeTabPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<HomeTabController>(
        tag: widget._controller.id,
        builder: ((_) {
          return Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
            child: SmartRefresher(
              enablePullUp: true,
              header: const RefreshHeader(),
              footer: const RefreshFooter(),
              controller: widget._controller.refreshController,
              onRefresh: widget._controller.onRefresh,
              onLoading: widget._controller.onLoadMore,
              child: MasonryGridView.count(
                itemCount: widget._controller.dataSource.length,
                crossAxisCount: 2,
                mainAxisSpacing: 5.h,
                crossAxisSpacing: 5.w,
                itemBuilder: (context, index) {
                  if (widget._controller.dataSource.isEmpty) {
                    return Container();
                  }

                  final model = widget._controller.dataSource[index];
                  return ArticleCard(
                    model: model,
                    callback: (_) {
                      Get.toNamed(Routes.web, arguments: model);
                    },
                  );
                },
              ),
            ),
          );
        }),
    );
  }

}