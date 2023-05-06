
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}