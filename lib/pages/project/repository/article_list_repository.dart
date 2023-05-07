import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/article_info_entity.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/entity/page_entity.dart';
import 'package:getx_sample/enum/tag_type.dart';
import 'package:getx_sample/http/request.dart' as http;

import '../../../http/api.dart';

class ArticleListRepository extends IRepository {
  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getListArticle({required int page, required String id, required TagType tagType}) async {
    switch (tagType) {
      case TagType.project:
        final params = <String, String>{};
        params['cid'] = id.toString();
        final api = "${Api.getProjectClassifyList}${page.toString()}/json";
        return await http.Request.get(api: api, params: params);
      case TagType.publicNumber:
        final api = "${Api.getPubilicNumberList}${id.toString()}/${page.toString()}/json";
        return await http.Request.get(api: api);
    }
  }
}