import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mathgptpro_mclient_flutter/cache/session_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/user_cache.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:mathgptpro_mclient_flutter/utils/jwt_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/login_page.dart';

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

    bool result = JwtUtils.userInfoInitByJwt(jwt);
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
  Future<bool> userProfileUpdate(String firstName, String lastName) async {
    var data = {
      "firstName": firstName,
      "lastName": lastName,
    };

    await _dioUtils.postAu(MainUrl.userProfileUpdate, data: data);

    return true;
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
    Get.offAll(() => const LoginPage());
    //清空所有缓存
    globalSessionCache = SessionCache();
    globalSystemCache = SystemCache();
    globalUserCache = UserCache();
  }
}
