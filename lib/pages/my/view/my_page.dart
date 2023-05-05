import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/my/controller/my_controller.dart';
import 'package:getx_sample/widget/bottom_clipper.dart';

import '../../../account_manager/account_manager.dart';
import '../../../utils/resource_mananger.dart';

class MyPage extends GetView<MyController> {
  const MyPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final isLogin = AccountManager().isLogin.obs;
    final userInfo = AccountManager().myCoinInfo.obs;

    controller.autoLoginSuccessCallback = () {
      isLogin.value = AccountManager().isLogin;
      userInfo.value = AccountManager().myCoinInfo;
    };

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("我的"),
        trailing: Obx(() {
          return Visibility(
            visible: isLogin.value,
            child: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                final result = await controller.logout();
                userInfo.value = AccountManager().myCoinInfo;
                isLogin.value = result;
              },
            ),
          );
        }),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: ClipPath(
              clipper: BottomClipper(),
              child: Container(
                color: Theme.of(context).primaryColor.withAlpha(200),
                padding: EdgeInsets.only(top: 10),
                child: Obx(() {
                  return InkWell(
                    onTap: isLogin.value ? () {} : null,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Hero(
                              tag: "loginLogo",
                              child: ClipOval(
                                child: Image.asset(
                                    ImageHelper.wrapAssets('user_avatar.png'),
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                    color: isLogin.value ? Theme.of(context).colorScheme.secondary.withAlpha(200) : Theme.of(context).colorScheme.secondary.withAlpha(10),
                                    // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                    colorBlendMode: BlendMode.colorDodge),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(children: <Widget>[
                            Text(
                                isLogin.value ? "30Code" : "点我登录",
                                style: Theme.of(context).textTheme.titleSmall?.apply(color: Colors.white.withAlpha(200))),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                userInfo.value,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withAlpha(200), decoration: TextDecoration.underline)),
                          ]),
                        ]
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}