
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/account_info_entity.dart';

class AccountManager {

  AccountManager._();

  /// 类Swift的单例写法,这种写法的劣势是无法进行销毁,所以才有了clear方法
  static final shared = AccountManager._();

  /// 普通的单例写法
  static AccountManager? _instance;

  static AccountManager get instance => _instance ??= AccountManager._();

  /// GetX的单例写法
  factory AccountManager() => _instance ??= AccountManager._();

  /// 销毁单例
  static void destroyInstance() => _instance = null;

  AccountInfoEntity? info;

  Future<SharedPreferences> get userDefine async =>
      await SharedPreferences.getInstance();

  // 只读计算属性
  String get cookieHeaderValue {
    if (info?.username != null && info?.password != null) {
      return "loginUserName=${info?.username};loginUserPassword=${info?.password}";
    } else {
      return "";
    }
  }
}