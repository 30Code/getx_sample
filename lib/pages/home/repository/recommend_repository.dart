import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/entity/banner_entity.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/entity/page_entity.dart';
import 'package:getx_sample/http/api.dart';
import 'package:getx_sample/http/request.dart' as http;

class RecommendRepository extends IRepository {
  Future<BaseEntity<List<BannerEntity>>> getBanner() => http.Request.get(api: Api.getBanner);

  Future<BaseEntity<List<ArticleInfoDatas>>> getTopArticleList() => http.Request.get(api: Api.getTopArticleList);

  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getArticleList({required int page}) => http.Request.get(api: "${Api.getArticleList}${page.toString()}/json");
}