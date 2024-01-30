import 'package:get/get.dart';

//用户信息控制器
class UserController extends GetxController {
  RxString education = "".obs;

  RxString sub = "".obs;

  RxString userFirstName = "".obs;

  RxString userLastName = "".obs;

  RxBool subActived = false.obs;

  RxString subStatus = "".obs;

  RxInt proPlanCredit = 0.obs;

  RxInt maxPlanCredit = 0.obs;

  RxInt proExtraCredit = 0.obs;

  RxInt maxExtraCredit = 0.obs;
}
