import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';

class JwtUtils {
  /// 根据Jwt更新用户信息
  static bool userInfoInitByJwt(String jwt) {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(jwt);

      GetStorage().write(KeyValueStorageResource.jwtExpireTime, payload["exp"]);
      GetStorage().write(KeyValueStorageResource.jwt, jwt);
      GetStorage()
          .write(KeyValueStorageResource.userFirstName, payload["firstName"]);
      GetStorage()
          .write(KeyValueStorageResource.userLastName, payload["lastName"]);
      GetStorage().write(KeyValueStorageResource.userId, payload["userId"]);
      GetStorage()
          .write(KeyValueStorageResource.trialCount, payload["trialCount"]);
      GetStorage()
          .write(KeyValueStorageResource.subActived, payload["subActived"]);
      GetStorage()
          .write(KeyValueStorageResource.subStatus, payload["subStatus"]);

      String userFirstName = payload["firstName"] ?? "";
      String userLastName = payload["lastName"] ?? "";
      int trialCount = payload["trialCount"] ?? 0;
      bool subActived = payload["subActived"] ?? false;
      String subStatus = payload["subStatus"] ?? "";

      UserController userController = Get.find();
      userController.userFirstName.value = userFirstName;
      userController.userLastName.value = userLastName;
      userController.trialCount.value = trialCount;
      userController.subActived.value = subActived;
      userController.subStatus.value = subStatus;
      return true;
    } catch (e) {
      log.printError(info: e.toString());
      return false;
    }
  }
}
