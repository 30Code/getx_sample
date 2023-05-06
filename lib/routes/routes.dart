
import 'package:get/get.dart';
import 'package:getx_sample/account_manager/account_binding.dart';
import 'package:getx_sample/pages/home/binding/home_binding.dart';
import 'package:getx_sample/pages/main/binding/main_binding.dart';
import 'package:getx_sample/pages/my/binding/my_binding.dart';
import 'package:getx_sample/pages/rank/view/rank_page.dart';
import '../pages/launch/splash_page.dart';

import '../pages/common/unknown_page.dart';
import '../pages/main/view/main_page.dart';
import '../pages/my/view/login_page.dart';
import '../pages/project/binding/project_binding.dart';
import '../pages/rank/binding/rank_binding.dart';

abstract class Routes {
  Routes._();

  static const main = "/main";
  static const login = "/login";
  static const register = "/register";
  static const splash = "/splash";
  static const web = "/web/:notShowCollectIcon";
  static const myCoinHistory = "/myCoinHistory";
  static const myCollect = "/myCollect";
  static const coinRink = '/coinRink';
  static const hotKey = "/hotKey";
  static const unknown = "/unknown";

  static final routePage = [
    GetPage(
        name: splash,
        page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [
        MainBinding(),
        RankBinding(),
        ProjectBinding(),
      ]
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
  ];

  static final unknownPage = GetPage(
    name: Routes.unknown,
    page: () => const UnknownPage(),
  );
}