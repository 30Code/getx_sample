import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_sample/enum/scroll_view_action_type.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/extension/string_extension.dart';
import 'package:getx_sample/logger/logger.dart';
import 'package:getx_sample/pages/common/status_view.dart';
import 'package:getx_sample/pages/project/controller/project_controller.dart';
import 'package:getx_sample/pages/project/controller/article_list_controller.dart';
import 'package:getx_sample/pages/project/view/article_list_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _projectTabsController = Get.find<ProjectController>();

  final _alreadyRequestIndex = <int>{};

  final List<ArticleListController> _articleListControllers = [];

  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StatusView<ProjectController>(
        controller: _projectTabsController,
        contentBuilder: (_) {
          _tabController = TabController(length: _projectTabsController.data?.length ?? 0, vsync: this);
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
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: MaterialApp(
                home: _tabBar(_tabController),
                debugShowCheckedModeBanner: false,
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: _createProjectPage(),
            ),
          );
        },
      ),
    );
  }

  TabBar _tabBar(TabController controller) {
    return TabBar(
      tabs: (_projectTabsController.data ?? []).map(
            (model) {
          return Tab(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(model.name.toString().replaceHtmlElement),
            ),
          );
        },
      ).toList(),
      controller: controller,
      isScrollable: true,
      indicatorColor: Theme.of(context).primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
      unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      labelColor: Colors.black,
      labelPadding: const EdgeInsets.all(0.0),
      indicatorPadding: const EdgeInsets.all(0.0),
      indicatorWeight: 2.3,
      unselectedLabelColor: Colors.grey,
    );
  }

  List<Widget> _createProjectPage() {
    return (_projectTabsController.data ?? []).map((model) {
      final controller = ArticleListController();
      controller.tagType = _projectTabsController.type;
      controller.id = model.id.toString();
      controller.request = Get.find();
      controller.refreshController = RefreshController(initialRefresh: true);
      controller.page = _projectTabsController.type.pageNum;
      controller.initPage = _projectTabsController.type.pageNum;
      Get.put(controller, tag: model.id.toString());
      _articleListControllers.add(controller);
      return ArticleListPage(
        controller: controller,
      );
    }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}