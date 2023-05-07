import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../entity/banner_entity.dart';
import '../../utils/resource_manager.dart';

/// 首页推荐页轮播图
class RecommendBanner extends StatelessWidget {
  final List<BannerEntity> bannerList;
  final double bannerHeight;
  final EdgeInsets? padding;

  const RecommendBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    return Swiper(
      key: UniqueKey(),
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _item(bannerList[index]);
      },
      //自定义指示器
      pagination: const SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _item(BannerEntity bannerMo) {
    return InkWell(
      onTap: () {
        // AppRoutes.toUrl(bannerMo.url!);
      },
      child: Container(
        padding: padding,
        //圆角
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)).r,
          child: Image.asset(ImageHelper.wrapAssets("icon_banner_home_become_coach.png"), fit: BoxFit.fill,),
          // child: cachedImage(
          //   bannerMo.imagePath ?? "",
          // ),
        ),
      ),
    );
  }
}
