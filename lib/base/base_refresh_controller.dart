
import 'package:get/get.dart';
import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/enum/response_status.dart';
import 'package:getx_sample/enum/scroll_view_action_type.dart';
import 'package:getx_sample/logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../entity/page_entity.dart';

abstract class BaseRefreshController<R extends IRepository, T> extends GetxController implements IRetry {

  late R request;

  late RefreshController refreshController;

  late int page;

  late int initPage;

  ResponseStatus status = ResponseStatus.loading;

  BaseEntity<PageEntity<List<T>>>? response;

  List<T> dataSource = [];

  @override
  void onInit() {
    super.onInit();
    request = Get.find<R>();
  }

  @override
  void onClose() {
    super.onClose();
    logger.d("onClose");
  }

  Future<void> onRefresh() async {}

  Future<void> onLoadMore() async {}

  Future<void> asyncRequest({required ScrollViewActionType type, Map<String, dynamic>? parameters}) async {}

  void refreshControllerStatusUpdate(ScrollViewActionType type) {
    switch (type) {
      case ScrollViewActionType.refresh:
        refreshController.refreshCompleted(resetFooterState: true);
        if (response?.data?.curPage == response?.data?.pageCount) {
          refreshController.loadNoData();
        }
        break;
      case ScrollViewActionType.loadMore:
        if (response?.data?.curPage == response?.data?.pageCount) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }

        checkDataSourceAndStatus();
        break;
    }
  }

  void checkDataSourceAndStatus() {
    if ((status == ResponseStatus.successNoData && dataSource.isNotEmpty)
        || (status == ResponseStatus.fail && dataSource.isNotEmpty)) {
      status = ResponseStatus.successHasContent;
    }
  }

  void failHandle(ScrollViewActionType type) {
    if (type == ScrollViewActionType.loadMore) {
      page = page - 1;
    }

    status = ResponseStatus.fail;
    refreshControllerStatusUpdate(type);
  }

  @override
  void retry() {
    onRefresh();
  }

  processError({required ScrollViewActionType type, dynamic error}) {
    failHandle(type);
    update();
    return error;
  }

}