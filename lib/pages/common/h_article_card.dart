import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/resource/colors.dart';
import 'package:getx_sample/utils/format_util.dart';
import 'package:getx_sample/utils/resource_manager.dart';
import 'package:getx_sample/utils/view_utils.dart';

import '../../resource/res.dart';

class HArticleCard extends StatelessWidget {

  final ArticleInfoDatas _model;

  final ValueChanged<ArticleInfoDatas> _cellTapCallback;

  const HArticleCard({Key? key, required ArticleInfoDatas model, required ValueChanged<ArticleInfoDatas> callback})
      : _model = model, _cellTapCallback = callback, super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _cellTapCallback(_model);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: borderLine(context),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        height: 137.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _model.title!,
                    maxLines: 3,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorRes.color_232323,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2).r,
                        decoration: BoxDecoration(
                          color: ColorRes.color_232323,
                          borderRadius: BorderRadius.circular(2).r,
                        ),
                        child: Text(
                          "Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text(
                        _model.chapterName!,
                        style: TextStyle(
                          color: ColorRes.color_6D7278,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5).r,
                  child: Stack(
                    children: [
                      Image.asset(ImageHelper.wrapAssets("bg_game_modern.png"), width: 129.w, height: 80.h, fit: BoxFit.cover,),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(4).r,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h,),
                          child: Text(durationTransform(5000), style: TextStyle(color: Colors.white, fontSize: 9.sp),),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    //浏览角标
                    Image.asset(
                      Res.imageViews,
                      width: 14.w,
                      height: 14.w,
                    ),
                    //浏览数
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      countFormat(15000),
                      style: TextStyle(
                          color: ColorRes.color_AAAAB9,
                          fontSize: 10.sp,
                          height: 1.1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}