import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/tab_entity.dart';

import '../../../entity/base_entity.dart';
import '../../../enum/tag_type.dart';
import '../../../http/request.dart' as http;

class ProjectRepository extends IRepository {

  TagType type;

  ProjectRepository(this.type);

  Future<BaseEntity<List<TabEntity>>> getTab() => http.Request.get(api: type.tabApi);

}