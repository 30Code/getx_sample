
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_sample/account_manager/account_binding.dart';
import 'package:getx_sample/base/getx_router_observer.dart';
import 'package:getx_sample/extension/theme_data_extension.dart';
import 'package:getx_sample/logger/logger.dart';
import 'package:getx_sample/routes/routes.dart';

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: "GetX Sample",
      navigatorObservers: [GetXRouterObserver()],
      unknownRoute: Routes.unknownPage,
      initialRoute: Routes.splash,
      getPages: Routes.routePage,
      onGenerateRoute: (settings) {
        logger.d(settings.name);
        return null;
      },
      initialBinding: AccountBinding(),
      builder: EasyLoading.init(),
      theme: _getCupertinoCurrentTheme(),
    );
  }

  ThemeData _getMaterialCurrentTheme() {
    return SchedulerBinding.instance.window.platformBrightness.themeData;
  }

  CupertinoThemeData _getCupertinoCurrentTheme() {
    return const CupertinoThemeData(
      barBackgroundColor: Colors.white,
      brightness: Brightness.light
    );
  }

}