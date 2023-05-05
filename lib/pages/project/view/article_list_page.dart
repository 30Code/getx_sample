
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/refresh_header_footer.dart';
import 'package:getx_sample/pages/project/controller/article_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/routes.dart';
import '../../common/info_cell.dart';

class ArticleListPage extends StatefulWidget {

  final ArticleListController _controller;

  const ArticleListPage({Key? key, required ArticleListController controller}) : _controller = controller, super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListPageState();

}

class _ArticleListPageState extends State<ArticleListPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ArticleListController>(
        tag: widget._controller.id,
        builder: ((_) {
          return SmartRefresher(
            enablePullUp: true,
            header: const RefreshHeader(),
            footer: const RefreshFooter(),
            controller: widget._controller.refreshController,
            onRefresh: widget._controller.onRefresh,
            onLoading: widget._controller.onLoadMore,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget._controller.dataSource.length,
                itemBuilder: (BuildContext context, int index) {
                  if (widget._controller.dataSource.isEmpty) {
                    return Container();
                  }

                  final model = widget._controller.dataSource[index];
                  return InfoCell(
                    model: model,
                    callback: (_) {
                      Get.toNamed(Routes.web, arguments: model);
                    },
                  );
                },
            ),
          );
        }),
    );
  }

}