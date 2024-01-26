import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/loading_dialog.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';

import '../../utils/toast_utils.dart';

class UserInfoEditPage extends StatefulWidget {
  const UserInfoEditPage({Key? key}) : super(key: key);

  @override
  _UserInfoEditPageState createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final UserController _userController = Get.find();

  @override
  void initState() {
    super.initState();
    String userFirstName = _userController.userFirstName.value;
    String userLastName = _userController.userLastName.value;

    _firstNameController.text = userFirstName;
    _lastNameController.text = userLastName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: context.theme.primaryIconTheme,
        title: Text(
          "用户名修改".tr,
          style: context.textTheme.bodyLarge!.copyWith(fontSize: 16),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Container(
              height: 10.h,
            ),
            TextField(
              maxLines: 1,
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: _lastNameController,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  fontSize: 18, color: context.textTheme.bodyMedium!.color),
              decoration: InputDecoration(
                  labelText: "姓".tr, labelStyle: const TextStyle(height: 0.8)),
            ),
            Container(
              height: 15.h,
            ),
            TextField(
              maxLines: 1,
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: _firstNameController,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  fontSize: 18, color: context.textTheme.bodyMedium!.color),
              decoration: InputDecoration(
                  labelText: "名".tr, labelStyle: const TextStyle(height: 0.8)),
            ),
            Container(
              height: 15.h,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                color: UiResource.primaryBlue,
                child: Text(
                  "修改".tr,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  String lastName = _lastNameController.text;
                  String firstName = _firstNameController.text;

                  //在打开Dialog之前，要先取消键盘的焦点
                  FocusScope.of(context).unfocus();
                  Get.dialog(const LoadingDialog());

                  UserService userService = UserService();
                  await userService.userProfileUpdate(firstName, lastName);

                  _userController.userFirstName.value = firstName;
                  _userController.userLastName.value = lastName;

                  Get.back(closeOverlays: true);
                  ToastUtils.showInfoToast("修改成功".tr);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
