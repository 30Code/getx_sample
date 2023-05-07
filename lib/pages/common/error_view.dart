import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resource/colors.dart';
import '../../resource/res.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback? retryAction;

  const ErrorView({Key? key, this.retryAction}) : super(key: key);

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
            "加载异常",
            style: TextStyle(color: ColorRes.color_AAAAB9, fontSize: 14.sp),
          ),
          SizedBox(
            height: 37.h,
          ),
          SizedBox(
            height: 44.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  if (retryAction != null) {
                    retryAction!();
                  }
                },
                child: Text("重试", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
              ),
            ),
          )
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text(
    //           '哎呀,出错了...',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //         const SizedBox(
    //           height: 44,
    //         ),
    //         SizedBox(
    //           height: 44,
    //           width: double.infinity,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20),
    //             child: TextButton(
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all(
    //                     Theme.of(context).primaryColor),
    //               ),
    //               onPressed: () {
    //                 if (retryAction != null) {
    //                   retryAction!();
    //                 }
    //               },
    //               child: const Text(
    //                 "重试",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
