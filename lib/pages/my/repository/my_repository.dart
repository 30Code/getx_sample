import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/account_info_entity.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/http/api.dart';
import 'package:getx_sample/http/request.dart' as http;

import '../../../entity/coin_rank_entity.dart';

class MyRepository extends IRepository {

  Future<BaseEntity<AccountInfoEntity>> login({required String username, required String password}) async {
    final params = <String, String>{};
    params['username'] = username;
    params['password'] = password;
    return await http.Request.post(api: Api.postLogin, params: params);
  }

  Future<BaseEntity<Object?>> logout() => http.Request.get(api: Api.getLogout);

  Future<BaseEntity<CoinRankDatas>> getUserCoinInfo() => http.Request.get(api: Api.getUserCoinInfo);

}