import 'package:get/get.dart';

//用户信息控制器
class UserController extends GetxController {
  RxString userFirstName = "".obs;

  RxString userLastName = "".obs;

  RxInt trialCount = 0.obs;

  RxBool subActived = false.obs;

  RxString subStatus = "".obs;
}
