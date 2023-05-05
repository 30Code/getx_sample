
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_sample/enum/main_tag_type.dart';
import 'package:getx_sample/pages/main/controller/main_controller.dart';

import '../../../account_manager/account_controller.dart';
import '../../../logger/logger.dart';

class MainPage extends GetView<MainController> {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    logger.d(accountController);
    return GetBuilder<MainController>(
        builder: ((controller) {
          return CupertinoTabScaffold(
              tabBuilder: (context, index) {
                final type = MainTagType.values[index];
                return CupertinoTabView(builder: (context) {
                  return type.page;
                },);
              },
              tabBar: CupertinoTabBar(
                items: MainTagTypeExt.items,
                currentIndex: controller.selectedIndex,
                onTap: controller.onItemTapped,
              ),
          );
        }),
    );
  }

}