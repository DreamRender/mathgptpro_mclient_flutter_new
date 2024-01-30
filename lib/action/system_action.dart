import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/model/education_list.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/constant_controller.dart';

class SystemAction {
  final UserService userService = UserService();

  /// 更新用户教育信息
  Future<void> updateEducationList() async {
    ConstantController constantController = Get.find();

    List<EducationInfo> educationList = await userService.getEducationList();
    Map<int, String> educationInfoMap = {};

    for (EducationInfo educationInfo in educationList) {
      educationInfoMap[educationInfo.id!] = educationInfo.code!;
    }

    constantController.educationInfoMap = educationInfoMap;
    constantController.update();
  }
}
