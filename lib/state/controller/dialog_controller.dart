import 'package:get/get.dart';

class DialogController extends GetxController {
  List<int> thumbUpDialogIdList = [];

  List<int> thumbDownDialogIdList = [];

  thumbUpDialogIdListAdd(int id) {
    thumbUpDialogIdList.add(id);
    thumbDownDialogIdList.remove(id);
    update();
  }

  thumbDownDialogIdListAdd(int id) {
    thumbUpDialogIdList.remove(id);
    thumbDownDialogIdList.add(id);
    update();
  }
}
