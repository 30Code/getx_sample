
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/router_report.dart';

class GetXRouterObserver extends NavigatorObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    RouterReportManager.reportCurrentRoute(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    RouterReportManager.reportRouteDispose(route);
  }

}