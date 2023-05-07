import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/resource/colors.dart';
import 'package:getx_sample/utils/format_util.dart';
import 'package:getx_sample/utils/resource_manager.dart';

import '../../resource/res.dart';

class ArticleCard extends StatelessWidget {

  final ArticleInfoDatas _model;

  final ValueChanged<ArticleInfoDatas> _cellTapCallback;

  const ArticleCard({Key? key, required ArticleInfoDatas model, required ValueChanged<ArticleInfoDatas> callback})
      : _model = model, _cellTapCallback = callback, super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _cellTapCallback(_model);
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(ImageHelper.wrapAssets("bg_game_modern.png"),),
                  //封面文字
                  Positioned(left: 0, right: 0, bottom: 0, child: _coverInfo())
                ],
              ),
              // 标题
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
                child: Text(
                  _model.title!,
                  maxLines: 2,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorRes.color_232323,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              //作者图片,名字,浏览数量
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //作者图片,圆角设置图片宽度的一半
                          ClipRRect(
                            child: Image.asset(ImageHelper.wrapAssets("app_logo.png"), width: 18.w, height: 18.h, fit: BoxFit.cover,),
                            borderRadius: BorderRadius.circular(9).r,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          //用户名
                          _limitWidthText(_model.chapterName!),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //浏览角标
                          Image.asset(
                            Res.imageViews,
                            width: 14.w,
                            height: 14.w,
                          ),
                          //浏览数
                          SizedBox(width: 4.w,),
                          Text(
                            countFormat(18000),
                            style: TextStyle(
                                color: ColorRes.color_AAAAB9,
                                fontSize: 10.sp,
                                height: 1.1),
                          ),
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 7.h, bottom: 13.h).r),
            ],
          ),
        ),
      ),
    );
  }

  Widget _limitWidthText(String text) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 70.w,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(color: ColorRes.color_767A7F, fontSize: 11.sp, height: 1.1),
      ),
    );
  }

  Widget _coverInfo() {
    return Container(
      //从下到上的渐变
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            durationTransform(6000),
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          )
        ],
      ),
    );
  }
}