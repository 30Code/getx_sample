
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_sample/pages/common/countdown_circle.dart';
import 'package:getx_sample/routes/routes.dart';

///启动页
class SplashPage extends StatelessWidget {

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_login_pic.webp"),
                fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 88,
          child: CountdownCircle(finished: (byUserClick) {
            Get.offAllNamed(Routes.main);
          },),
        ),
      ],
    );
  }

}