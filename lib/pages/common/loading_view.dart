import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../resource/colors.dart';
import '../../resource/res.dart';

class LoadingView extends StatelessWidget {
  final String? _message;

  const LoadingView({Key? key, String? message}) : 
    _message = message, 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const CupertinoActivityIndicator(radius: 20),
            // const SizedBox(
            //   height: 10.0,
            // ),
            // Text(_message ?? '正在加载...'),
            Lottie.asset(Res.lottiePageLoading,
                width: 105.h, height: 105.h, animate: true),
            Text(
              _message ?? '正在获取数据...',
              style: TextStyle(color: ColorRes.color_AAAAB9, fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
  }
}
