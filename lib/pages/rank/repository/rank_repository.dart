import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/entity/coin_rank_entity.dart';
import 'package:getx_sample/entity/page_entity.dart';
import 'package:getx_sample/http/request.dart';

import '../../../http/api.dart';

class RankRepository extends IRepository {

  Future<BaseEntity<PageEntity<List<CoinRankDatas>>>> getCoinRankList(int page) => Request.get(api: "${Api.getRankingList}${page.toString()}/json");

}