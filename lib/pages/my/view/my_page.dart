import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sample/enum/my.dart' as my;
import 'package:getx_sample/pages/my/controller/my_controller.dart';
import 'package:getx_sample/routes/routes.dart';
import 'package:getx_sample/widget/bottom_clipper.dart';
import 'package:getx_sample/widget/image.dart';

import '../../../account_manager/account_manager.dart';
import '../../../utils/resource_manager.dart';

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
      navigationBar: const CupertinoNavigationBar(
        middle: Text("我的"),
        // trailing: Obx(() {
        //   return Visibility(
        //     visible: isLogin.value,
        //     child: IconButton(
        //       icon: const Icon(Icons.exit_to_app),
        //       onPressed: () async {
        //         final result = await controller.logout();
        //         userInfo.value = AccountManager().myCoinInfo;
        //         isLogin.value = result;
        //       },
        //     ),
        //   );
        // }),
      ),
      child: Obx(() {
        final dataSource = isLogin.value ? my.Extension.userDataSource : my.Extension.visitorDataSource;
        return ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageHelper.wrapAssets("user_avatar.png"),
                        fit: BoxFit.cover,
                        width: 85,
                        height: 85,
                      ),
                      Text(userInfo.value),
                    ],
                  ),
                  // child: ClipPath(
                  //   clipper: BottomClipper(),
                  //   child: Container(
                  //     color: Theme.of(context).primaryColor.withAlpha(200),
                  //     padding: const EdgeInsets.only(top: 10),
                  //     child: InkWell(
                  //       onTap: isLogin.value ? null : () {
                  //         Get.toNamed(Routes.unknown);
                  //       },
                  //       child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             InkWell(
                  //               child: Hero(
                  //                 tag: "loginLogo",
                  //                 child: ClipOval(
                  //                   child: Image.asset(
                  //                       ImageHelper.wrapAssets('user_avatar.png'),
                  //                       fit: BoxFit.cover,
                  //                       width: 80,
                  //                       height: 80,
                  //                       color: isLogin.value ? Theme.of(context).colorScheme.secondary.withAlpha(200) : Theme.of(context).colorScheme.secondary.withAlpha(10),
                  //                       // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                  //                       colorBlendMode: BlendMode.colorDodge),
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 20,
                  //             ),
                  //             Column(children: <Widget>[
                  //               Text(
                  //                   isLogin.value ? "30Code" : "点我登录",
                  //                   style: Theme.of(context).textTheme.titleSmall?.apply(color: Colors.white.withAlpha(200))),
                  //               const SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                   userInfo.value,
                  //                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withAlpha(200), decoration: TextDecoration.underline)),
                  //             ]),
                  //           ]
                  //       ),
                  //     ),
                  //   ),
                  // ),
                );
              } else {
                final model = dataSource[index];
                return ListTile(
                  leading: Icon(model.icon),
                  title: Text(model.title),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    if (model == my.My.login) {
                      final result = await Get.toNamed(Routes.login);
                      if (result != null) {
                        isLogin.value = result;
                        userInfo.value = controller.userInfo;
                      }
                    } else if (model == my.My.logout) {
                      showCupertinoDialog(
                          context: context,
                          builder: ((context) {
                            return CupertinoAlertDialog(
                              title: const Text('提示'),
                              content: const Text('是否登出?'),
                              actions: <Widget>[
                                TextButton(onPressed: () => Get.back(), child: Text('取消', style: TextStyle(color: Theme.of(context).primaryColor),)),
                                TextButton(
                                    onPressed: () async {
                                      Get.back();
                                      final result = await controller.logout();
                                      userInfo.value = AccountManager().myCoinInfo;
                                      isLogin.value = result;
                                    },
                                    child: Text('确定', style: TextStyle(color: Theme.of(context).primaryColor),)
                                ),
                              ],
                            );
                          }),
                      );
                    } else {
                      Get.toNamed(model.path);
                    }
                  },
                );
              }
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1.0,
              );
            },
            itemCount: dataSource.length
        );
      }),
    );
  }
}