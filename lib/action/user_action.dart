import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/model/balance_info.dart';
import 'package:mathgptpro_mclient_flutter/model/user_info.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/constant_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';

class UserAction {
  final UserService userService = UserService();

  /// 更新用户额度信息
  Future<void> updateUserBalance({BalanceInfo? balanceInfo}) async {
    final UserController userController = Get.find();

    balanceInfo ??= await userService.getBalanceInfo();

    userController.maxExtraCredit.value = balanceInfo.maxExtraCredit ?? 0;
    userController.maxPlanCredit.value = balanceInfo.maxPlanCredit ?? 0;
    userController.proExtraCredit.value = balanceInfo.proExtraCredit ?? 0;
    userController.proPlanCredit.value = balanceInfo.proPlanCredit ?? 0;
  }

  /// 更新用户教育信息
  Future<void> updateUserEducationInfo() async {
    ConstantController constantController = Get.find();
    UserController userController = Get.find();

    UserInfo userInfo = await userService.getUserInfo();

    Map<int, String> educationInfoMap = constantController.educationInfoMap;

    //更新教育信息
    userController.education.value = educationInfoMap[userInfo.eduId!] ?? "";
  }

  bool userInfoInitByJwt(String jwt) {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(jwt);

      GetStorage().write(KeyValueStorageResource.jwtExpireTime, payload["exp"]);
      GetStorage().write(KeyValueStorageResource.jwt, jwt);

      String sub = payload["sub"] ?? "";
      String userFirstName = payload["firstName"] ?? "";
      String userLastName = payload["lastName"] ?? "";
      bool subActived = payload["subActived"] ?? false;
      String subStatus = payload["subStatus"] ?? "";

      UserController userController = Get.find();
      userController.sub.value = sub;
      userController.userFirstName.value = userFirstName;
      userController.userLastName.value = userLastName;
      userController.subActived.value = subActived;
      userController.subStatus.value = subStatus;
      return true;
    } catch (e) {
      log.printError(info: e.toString());
      return false;
    }
  }
}
