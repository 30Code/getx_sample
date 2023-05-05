
abstract class IRepository {}

/// 重试机制
abstract class IRetry {
  /// 这里写不写方法的实现好像并不影响代码编译与逻辑
  void retry();
}

/// 跳转Web的模型基类
abstract class IWebLoadInfo {
  int? id;
  int? originId;
  String? title;
  String? link;
}