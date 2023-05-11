import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/article_info_entity.dart';
import '../../../resource/colors.dart';
import '../../../utils/format_util.dart';
import '../../../utils/view_utils.dart';


/// 视频详情用户信息 一键三连ui
class ViewToolBar extends StatelessWidget {
  final ArticleInfoDatas videoDetailMo;

  final VoidCallback? onLike;
  final VoidCallback? onUnLike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const ViewToolBar(
      {Key? key,
      required this.videoDetailMo,
      this.onLike,
      this.onUnLike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(border: borderLine(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(
              Icons.thumb_up_alt_rounded, videoDetailMo.id!,
              onClick: onLike, tint: true),
          _buildIconText(Icons.thumb_down_alt_rounded, '不喜欢',
              onClick: onUnLike),
          _buildIconText(Icons.monetization_on, videoDetailMo.id,
              onClick: onCoin),
          _buildIconText(Icons.grade_rounded, videoDetailMo.id,
              onClick: onFavorite, tint: true),
          _buildIconText(Icons.share_rounded, videoDetailMo.id,
              onClick: onShare),
        ],
      ),
    );
  }

  /// 构建图标文本
  Widget _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    //文本处理
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= '';
    }
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            color: tint ? ColorRes.color_232323 : Colors.grey, //着色
            size: 20.h,
          ),
          hiSpace(height: 5.h),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
