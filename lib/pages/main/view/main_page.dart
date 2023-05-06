import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/main/controller/main_controller.dart';
import 'package:getx_sample/pages/rank/view/rank_page.dart';
import 'package:getx_sample/resource/res.dart';
import 'package:getx_sample/resource/strings.dart';
import 'package:getx_sample/widget/keep_alive_wrapper.dart';
import 'package:getx_sample/widget/lottie_bottom_bar.dart';

import '../../common/unknown_page.dart';

class MainPage extends GetView<MainController> {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        builder: ((controller) {
          return Material(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    children: [
                      KeepAliveWrapper(
                        child: UnknownPage(),
                      ),
                      KeepAliveWrapper(
                        child: RankPage(),
                      ),
                    ],
                  ),
                ),
                LottieBottomBar(
                  [
                    LottieItem(StringRes.home, Res.lottieBottomTab1),
                    LottieItem(StringRes.rank, Res.lottieBottomTab2),
                  ],
                  currentIndex: 0,
                  onBottomItemChanged: (index) {
                    controller.pageController.jumpToPage(index);
                  },
                ),
              ],
            ),
          );
        }),
    );
  }

}