import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../entity/article_info_entity.dart';
import '../../../utils/view_utils.dart';


/// 可展开的widget
class ExpandableContent extends StatefulWidget {
  final ArticleInfoDatas videoInfo;

  const ExpandableContent({Key? key, required this.videoInfo})
      : super(key: key);

  @override
  State<ExpandableContent> createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  late AnimationController _animationController;

  ///动画曲线
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  /// 动画
  late Animation<double> _heightAnimation;

  /// 是否展开
  bool _expand = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightAnimation = _animationController.drive(_easeInTween);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h),
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(
            height: 5.h,
          ),
          _buildInfo(),
          _buildDes(),
        ],
      ),
    );
  }

  /// 切换动画
  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        //执行动画
        _animationController.forward();
      } else {
        //反向执行动画
        _animationController.reverse();
      }
    });
  }

  /// 标题
  Widget _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.videoInfo.title!,
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          //最右侧图标
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16.h,
          )
        ],
      ),
    );
  }

  /// 视频基础信息
  Widget _buildInfo() {
    var style = const TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.videoInfo.niceDate;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...smallIconText(Icons.ondemand_video, widget.videoInfo.id),
        const SizedBox(width: 15),
        ...smallIconText(Icons.list_alt, widget.videoInfo.id),
        Text('    $dateStr', style: style)
      ],
    );
  }

  /// 展开内容
  Widget _buildDes() {
    var child = _expand
        ? Text(
            "${widget.videoInfo.desc!}北京时间5月11日，NBA季后赛继续进行，勇士主场迎战湖人，此前勇士大比分1-3落后湖人，已经没有退路，今天要么赢球，要么出局。最终比分为121-106，勇士主场大胜。和前面4场比赛不太相同的是，今天勇士的爆发，始于库里，但是维金斯和格林两人打出侵略性后，湖人反而不太好处理，浓眉和老詹消耗都挺大。勇士温水煮青蛙，每节都在拉大分差，他们完成自我救赎。此外还有一点需要注意，今天湖人一共拿到15次罚球，勇士也拿到15次罚球。",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          )
        : null;
    return AnimatedBuilder(
        child: child,
        animation: _animationController.view,
        //指定需要执行动画widget的位置
        builder: (BuildContext context, Widget? child) {
          return Align(
            alignment: Alignment.topLeft,
            heightFactor: _heightAnimation.value, //高度变化
            child: Container(
              //指定位置
              padding: EdgeInsets.only(top: 8.h),
              child: child,
            ),
          );
        });
  }
}
