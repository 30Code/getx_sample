import 'package:getx_sample/base/interface.dart';

import '../../../entity/base_entity.dart';
import '../../../entity/tab_entity.dart';
import '../../../enum/tag_type.dart';
import 'package:getx_sample/http/request.dart' as http;

class HomeRepository extends IRepository {
  HomeRepository(this.type);

  TagType type;

  Future<BaseEntity<List<TabEntity>>> getTab() => http.Request.get(api: type.tabApi);
}