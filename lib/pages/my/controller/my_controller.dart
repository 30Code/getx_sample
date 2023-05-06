import 'package:get/get.dart';
import 'package:getx_sample/account_manager/account_manager.dart';
import 'package:getx_sample/base/base_request_controller.dart';
import 'package:getx_sample/base/resign_first_responder.dart';
import 'package:getx_sample/entity/account_info_entity.dart';
import 'package:getx_sample/pages/my/repository/my_repository.dart';

import '../../../logger/logger.dart';

class MyController extends BaseRequestController<MyRepository, AccountInfoEntity> {

  var userInfo = "等级 --  排名 --  积分 --";

  void Function()? autoLoginSuccessCallback;

  @override
  void onInit() {
    super.onInit();
    logger.d("onInit");
  }

  ///登录
  void login({required String username, required String password}) async {
    ResignFirstResponder.unfocus();
    final response = await request.login(username: username, password: password);
    String msg;
    if (response.isSuccess && response.data != null) {
      await AccountManager().save(info: response.data!, isLogin: true, password: password);
      await getUserCoinInfo();
      msg = '登录成功';
    } else {
      msg = '登录失败';
    }
    Get.snackbar("", msg, duration: const Duration(seconds: 1), snackbarStatus: (status) {
      if (status == SnackbarStatus.CLOSED) {
        navigator?.pop(AccountManager().isLogin);
      }
    });
  }

  ///自动登录
  Future<void> autoLogin() async {
    final username = await AccountManager().getLastLoginUserName();
    final password = await AccountManager().getLastLoginPassword();

    if (username.isNotEmpty && password.isNotEmpty) {
      final response = await request.login(username: username, password: password);
      String msg;
      if (response.isSuccess && response.data != null) {
        await AccountManager().save(info: response.data!, isLogin: true, password: password);
        msg = "自动登录成功";
        await getUserCoinInfo();
        if (autoLoginSuccessCallback != null) {
          autoLoginSuccessCallback!();
        }
      } else {
        msg = "自动登录失败";
      }
      Get.snackbar("", msg, duration: const Duration(seconds: 1),);
    }
  }

  ///登出
  Future<bool> logout() async {
    final response = await request.logout();
    String message;
    if (response.isSuccess) {
      message = "登出成功";
      AccountManager().clear();
    } else {
      message = "登出失败";
    }
    Get.snackbar(
      "",
      message,
      duration: const Duration(seconds: 1),
    );
    return AccountManager().isLogin;
  }

  ///获取用户排名信息
  Future<String> getUserCoinInfo() async {
    final response = await request.getUserCoinInfo();
    final userInfo = "等级 ${response.data?.level ?? "--"}  排名 ${response.data?.rank ?? "--"}  积分 ${response.data?.coinCount ?? "--"}";
    this.userInfo = userInfo;
    AccountManager().myCoinInfo = userInfo;
    return userInfo;
  }

}