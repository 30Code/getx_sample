import 'package:flutter/material.dart';

import '../routes/routes.dart';

enum My {
  header,
  ranking,
  myCoin,
  myCollect,
  login,
  logout,
}

extension Extension on My {
  String get title {
    switch (this) {
      case My.header:
        return "";
      case My.login:
        return "登录";
      case My.logout:
        return "登出";
      case My.myCoin:
        return "我的积分";
      case My.myCollect:
        return "我的收藏";
      case My.ranking:
        return "积分排名";
    }
  }

  String get path {
    switch (this) {
      case My.header:
        return "";
      case My.login:
        return Routes.login;
      case My.logout:
        return Routes.unknown;
      case My.myCoin:
        return Routes.myCoinHistory;
      case My.myCollect:
        return Routes.myCollect;
      case My.ranking:
        return Routes.coinRink;
    }
  }

  IconData get icon {
    switch (this) {
      case My.header:
        return Icons.usb;
      case My.login:
        return Icons.login;
      case My.logout:
        return Icons.logout;
      case My.myCoin:
        return Icons.trending_up;
      case My.myCollect:
        return Icons.local_offer;
      case My.ranking:
        return Icons.poll;
    }
  }

  static final visitorDataSource = [
    My.header,
    My.ranking,
    My.login,
  ];

  static final userDataSource = [
    My.header,
    My.ranking,
    My.myCoin,
    My.myCollect,
    My.logout,
  ];
}
