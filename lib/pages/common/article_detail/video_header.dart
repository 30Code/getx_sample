import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/article_info_entity.dart';
import '../../../resource/colors.dart';
import '../../../utils/format_util.dart';
import '../../../utils/loading.dart';
import '../../../utils/resource_manager.dart';

/// 视频详情头
class VideoHeader extends StatelessWidget {
  ArticleInfoDatas articleInfoDatas;

  VideoHeader(this.articleInfoDatas, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15,).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15).r,
                child: Image.asset(ImageHelper.wrapAssets("app_logo.png"), width: 30.w, height: 30.h, fit: BoxFit.cover,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(articleInfoDatas.chapterName!),
                    Text(
                      '${countFormat(52100)}粉丝',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              Loading.toast("暂不支持");
            },
            color: ColorRes.color_232323,
            height: 26.h,
            minWidth: 45.w,
            child: Text(
              "+ 关注",
              style: TextStyle(color: Colors.white, fontSize: 12.sp,height: 1.1),
            ),
          )
        ],
      ),
    );
  }
}