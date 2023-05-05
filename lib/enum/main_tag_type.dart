
import 'package:flutter/material.dart';
import 'package:getx_sample/pages/common/unknown_page.dart';
import 'package:getx_sample/pages/home/view/home_page.dart';
import 'package:getx_sample/pages/project/view/project_page.dart';

enum MainTagType {home, project, my}

extension MainTagTypeExt on MainTagType {

  Widget get page {
    switch (this) {
      case MainTagType.home:
        return const HomePage();
      case MainTagType.project:
        return const ProjectPage();
      case MainTagType.my:
        return const UnknownPage();
    }
  }

  static List<BottomNavigationBarItem> get items {
    return MainTagType.values
        .map(
          (type) => BottomNavigationBarItem(
        icon: Icon(type.icon),
        label: type.title,
      ),
    )
        .toList();
  }

  IconData get icon {
    switch (this) {
      case MainTagType.home:
        return Icons.home;
      case MainTagType.project:
        return Icons.web;
      case MainTagType.my:
        return Icons.person;
    }
  }

  String get title {
    switch (this) {
      case MainTagType.home:
        return "首页";
      case MainTagType.project:
        return "项目";
      case MainTagType.my:
        return "我的";
    }
  }

}

