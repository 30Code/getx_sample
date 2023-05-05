
import 'package:get/get.dart';
import 'package:getx_sample/base/interface.dart';
import 'package:getx_sample/entity/base_entity.dart';
import 'package:getx_sample/enum/response_status.dart';

abstract class BaseRequestController<R extends IRepository, T> extends GetxController implements IRetry {

  late R request;

  BaseEntity<T>? response;

  ResponseStatus status = ResponseStatus.loading;

  T? data;

  @override
  void onInit() {
    super.onInit();
    request = Get.find<R>();
  }

  Future<void> asyncRequest({Map<String, dynamic>? parameters}) async {}

  @override
  void retry() {
    asyncRequest();
  }

}