import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/entity/page_entity.dart';

import '../../../http/api.dart';
import 'package:getx_sample/http/request.dart' as http;

class ArticleDetailRepository extends IRepository {

  Future<BaseEntity<List<ArticleInfoDatas>>> getArticleDetailInfo() => http.Request.get(api: Api.getTopArticleList);

  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getCommentList({required int page, required String id}) async {
    final api = "${Api.getPubilicNumberList}${id.toString()}/${page.toString()}/json";
    return await http.Request.get(api: api);
  }

}