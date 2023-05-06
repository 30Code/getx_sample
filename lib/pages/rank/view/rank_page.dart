import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/refresh_header_footer.dart';
import 'package:getx_sample/pages/common/refresh_status_view.dart';
import 'package:getx_sample/pages/rank/controller/rank_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/routes.dart';

class RankPage extends GetView<RankController> {
  const RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('积分排名'),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.dataSource.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.dataSource[index];
                return ListTile(
                  leading: Text(model.rank.toString()),
                  title: Text(model.username.toString()),
                  trailing: Text('积分:${model.level.toString()}'),
                  onTap: () => Get.toNamed(Routes.unknown),
                );
              },
            ),
          );
        },
      ),
    );
  }
}