import 'dart:developer';

import 'package:dio/dio.dart' as the_dio;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/utils/jwt_utils.dart';

class DioUtils {
  /// 上一次执行退出的时间
  DateTime? lastExecuteLogoutTime;

  final Dio _dio = Dio();

  final BaseOptions baseOptions = BaseOptions(
      responseType: ResponseType.plain,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1));

  /// 检查网络状况
  static Future<bool> checkNetwork() async {
    //这个函数的Dio要单独做
    Dio dio = Dio();
    the_dio.Response response = await dio.head("https://www.baidu.com");
    log('网络状况：${response.statusCode}');
    return response.statusCode == 200;
  }

  /// 处理用户退出操作
  void logoutHandler() {
    //防止多次重复的执行退出操作
    //PS:有时可能不能达到预期效果，比如在Future.wait并发状态下
    if (lastExecuteLogoutTime == null ||
        DateTime.now().difference(lastExecuteLogoutTime!).inSeconds > 3) {
      //更新时间
      lastExecuteLogoutTime = DateTime.now();
      //正常退出
      UserService.logout();
    }
  }

  /// 获取用户Token
  Future<String?> getUserToken() async {
    String storageJwt =
        GetStorage().read<String?>(KeyValueStorageResource.jwt) ?? "";
    int jwtExpireTime =
        GetStorage().read<int?>(KeyValueStorageResource.jwtExpireTime) ?? 0;

    String? jwt = "";

    //已登录的情况
    DateTime jwtExpireTimeDateTime =
        DateTime.fromMillisecondsSinceEpoch(jwtExpireTime * 1000);

    if (jwtExpireTimeDateTime.isAfter(DateTime.now())) {
      log("使用缓存JWT数据");
      return storageJwt;
    } else {
      log("使用新请求的JWT");

      String accessKey =
          GetStorage().read<String?>(KeyValueStorageResource.accessKey) ?? "";

      jwt =
          (await post(MainUrl.accessKeyGetJwt, data: {"accessKey": accessKey}))
              .data
              .toString();
    }

    if (jwt == "null" || jwt.contains("INVALID_CREDENTIAL")) {
      return null;
    }

    return jwt;
  }

  /// 获取用户Token并更新用户信息
  Future<String?> getUserTokenWithUpdateUserInfo() async {
    String? jwt = await getUserToken();

    if (jwt == null) {
      return null;
    }

    JwtUtils.userInfoInitByJwt(jwt);

    return jwt;
  }

  Future<the_dio.Response> get(url, {paramMap, data, options}) async {
    return await _dio.get(url, queryParameters: paramMap, options: options);
  }

  Future<the_dio.Response> post(url, {paramMap, data, options}) async {
    return await _dio.post(url,
        queryParameters: paramMap, data: data, options: options);
  }

  Future<the_dio.Response> delete(url, {paramMap, data, options}) async {
    return await _dio.delete(url,
        queryParameters: paramMap, data: data, options: options);
  }

  Future<the_dio.Response> put(url, {paramMap, data, options}) async {
    return await _dio.put(url,
        queryParameters: paramMap, data: data, options: options);
  }

  /// GET获取
  Future<the_dio.Response> getAu(url, {paramMap}) async {
    String? token = await getUserTokenWithUpdateUserInfo();

    if (token == null) {
      logoutHandler();
    }

    String userToken = "Bearer $token";

    Map<String, dynamic> header = {"Authorization": userToken};

    return await get(url,
        paramMap: paramMap, options: Options(headers: header));
  }

  /// POST提交
  Future<the_dio.Response> postAu(url, {paramMap, data, contentType}) async {
    String? token = await getUserTokenWithUpdateUserInfo();

    if (token == null) {
      logoutHandler();
    }

    String userToken = "Bearer $token";

    Map<String, dynamic> header = {"Authorization": userToken};

    return await post(url,
        paramMap: paramMap,
        data: data,
        options: Options(headers: header, contentType: contentType));
  }

  /// DELETE删除
  Future<the_dio.Response> deleteAu(url, {paramMap, data}) async {
    String? token = await getUserTokenWithUpdateUserInfo();

    if (token == null) {
      logoutHandler();
    }

    String userToken = "Bearer $token";

    Map<String, dynamic> header = {"Authorization": userToken};

    return await delete(url,
        paramMap: paramMap, data: data, options: Options(headers: header));
  }

  DioUtils() {
    _dio.options = baseOptions;
    _dio.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      log(response.realUri.toString());
      log(response.data.toString());
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioException exception, handler) {
      log("--------------");
      log('出错链接(DioUtils)：${exception.requestOptions.path}');
      log(exception.toString());
      log("--------------");

      // //Sentry追踪（异步处理）
      // LogUtils.sendSentryTrackError(
      //     exception: "UrlError: ${exception.requestOptions.path}",
      //     stackTrace: exception.toString());
      //
      // //内部错误
      // if (exception.response!.statusCode == 500) {
      //   ToastUtils.showErrorToast("内部错误", displaySeconds: 3);
      // } else {
      //   ToastUtils.showErrorToast("网络连接错误", displaySeconds: 3);
      // }

      // return handler.next(error); //continue
      return handler.resolve(the_dio.Response(
          data: null,
          requestOptions: RequestOptions(
              data: null, path: exception.requestOptions.path))); //continue
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`the_dio.Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    }));
  }
}
