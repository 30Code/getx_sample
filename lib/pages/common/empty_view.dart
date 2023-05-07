import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resource/colors.dart';
import '../../resource/res.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorRes.color_F5F5F9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Res.imageStateEmpty,
            width: 150.w,
            height: 150.w,
          ),
          SizedBox(
            height: 37.h,
          ),
          Text(
            "无数据",
            style: TextStyle(color: ColorRes.color_AAAAB9, fontSize: 14.sp),
          )
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: const <Widget>[
    //         Text(
    //           '暂无数据',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
