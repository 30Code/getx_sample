
import 'package:get/get.dart';
import 'package:getx_sample/account_manager/account_binding.dart';
import 'package:getx_sample/pages/home/binding/home_binding.dart';
import 'package:getx_sample/pages/main/binding/main_binding.dart';
import 'package:getx_sample/pages/my/binding/my_binding.dart';
import '../pages/launch/splash_page.dart';

import '../pages/common/unknown_page.dart';
import '../pages/main/view/main_page.dart';
import '../pages/project/binding/project_binding.dart';

abstract class Routes {
  Routes._();

  static const main = "/main";
  static const login = "/login";
  static const splash = "/splash";
  static const web = "/web/:notShowCollectIcon";
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
        HomeBinding(),
        ProjectBinding(),
        MyBinding(),
        AccountBinding(),
      ]
    ),
  ];

  static final unknownPage = GetPage(
    name: Routes.unknown,
    page: () => const UnknownPage(),
  );
}