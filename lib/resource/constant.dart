abstract class Constant {

  /// BaseEntity
  static const String data = 'data';
  static const String errorCode = 'errorCode';
  static const String errorMsg = 'errorMsg';

  /// PageEntity
  static const String datas = 'datas';
  static const String curPage = "curPage";
  static const String offset = "offset";
  static const String over = "over";
  static const String pageCount = "pageCount";
  static const String size = "size";
  static const String total = "total";


  static const BARRAGE_URL = "wss://api.devio.org/uapi/fa/barrage/";

  //用户登录后,产生的令牌
  static const BOARDING_PASS = "33665CA3F23FEFE277A747A423BD9D43AF";
  static const COURSE_FLAG = "fa";

  //请求接口需要的token,定期修改,先本地写死
  static const AUTH_TOKEN = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";

  // socket 请求头
  static barrageHeaders() {
    Map<String, dynamic> header = {
      "auth-token": AUTH_TOKEN,
      "course-flag": COURSE_FLAG,
      "boarding-pass": BOARDING_PASS
    };
    return header;
  }

  static const VID = "vid";

}