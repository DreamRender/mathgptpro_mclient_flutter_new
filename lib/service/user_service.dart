import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mathgptpro_mclient_flutter/action/user_action.dart';
import 'package:mathgptpro_mclient_flutter/cache/session_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/user_cache.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/model/balance_info.dart';
import 'package:mathgptpro_mclient_flutter/model/education_list.dart';
import 'package:mathgptpro_mclient_flutter/model/user_info.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/welcome_page.dart';

class UserService {
  final DioUtils _dioUtils = DioUtils();

  /// 用户登录
  Future<bool> userLogin(String account, String password) async {
    String jwt = (await _dioUtils.post(MainUrl.login,
            data: {"username": account, "password": password}))
        .data
        .toString();

    if (jwt.contains("INVALID_CREDENTIAL")) {
      return false;
    }

    bool result = UserAction().userInfoInitByJwt(jwt);
    if (result) {
      await getAccessKey(jwt);
      return true;
    } else {
      return false;
    }
  }

  /// 获取AccessKey
  Future<void> getAccessKey(String jwtToken) async {
    String userToken = "Bearer $jwtToken";

    Map<String, dynamic> header = {"Authorization": userToken};

    String accessKey = (await _dioUtils.post(MainUrl.getAccessKey,
            options: Options(headers: header)))
        .data
        .toString();

    GetStorage().write(KeyValueStorageResource.accessKey, accessKey);
  }

  /// 更新用户信息
  Future<bool> userProfileUpdate(
      String firstName, String lastName, int eduId) async {
    var data = {"firstName": firstName, "lastName": lastName, "eduId": eduId};

    await _dioUtils.postAu(MainUrl.userProfileUpdate, data: data);

    return true;
  }

  /// 获得额度信息
  Future<BalanceInfo> getBalanceInfo() async {
    dio.Response response = await _dioUtils.getAu(MainUrl.getBalanceInfo);

    BalanceInfo result = BalanceInfo.fromJson(json.decode(response.data));

    return result;
  }

  /// 更新额度信息
  Future<BalanceInfo> updateUserBalanceHistory(String sessionModel) async {
    dio.Response response = await _dioUtils
        .postAu(MainUrl.updateBalanceHistory, data: {"model": sessionModel});

    BalanceInfo result = BalanceInfo.fromJson(json.decode(response.data));

    return result;
  }

  /// 获取用户信息
  Future<UserInfo> getUserInfo() async {
    dio.Response response = await _dioUtils.getAu(MainUrl.getUserInfo);

    UserInfo result = UserInfo.fromJson(json.decode(response.data));

    return result;
  }

  /// 获取Education List
  Future<List<EducationInfo>> getEducationList() async {
    dio.Response response = await _dioUtils.get(MainUrl.getEducationList);

    List<EducationInfo> list = List<EducationInfo>.from(json
        .decode(response.data)
        .map((model) => EducationInfo.fromJson(model)));

    return list;
  }

  /// 退出登录
  static void logout() async {
    log("退出登录");
    //删除所有记录
    await GetStorage().erase();
    //清空缓存
    globalSessionCache = SessionCache();
    //重新加载
    Get.reloadAll(force: true);
    //返回登录页
    Get.offAll(() => const WelcomePage());
    //清空所有缓存
    globalSessionCache = SessionCache();
    globalSystemCache = SystemCache();
    globalUserCache = UserCache();
  }
}
