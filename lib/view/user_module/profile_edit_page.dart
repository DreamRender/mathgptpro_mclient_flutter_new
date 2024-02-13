import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/action/user_action.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/constant_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/user_account_close_page.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final UserService userService = UserService();
  final UserAction userAction = UserAction();

  final ConstantController constantController = Get.find();
  final UserController userController = Get.find();

  final TextEditingController firstNameTextEditController =
      TextEditingController();
  final TextEditingController lastNameTextEditController =
      TextEditingController();

  Map<int, String> educationInfoMap = {};
  List<String> educationLevelItems = [];
  String? educationLevel;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    educationInfoMap = constantController.educationInfoMap;
    educationInfoMap.forEach((key, value) {
      educationLevelItems.add(value);
    });

    //userController.education.value无数据的时候会是“”
    if (userController.education.value != "") {
      educationLevel = userController.education.value;
    }
    firstNameTextEditController.text = userController.userFirstName.value;
    lastNameTextEditController.text = userController.userLastName.value;
  }

  /// 修改用户Profile
  onUpdate() async {
    //先关闭键盘
    FocusScope.of(Get.context!).unfocus();

    setState(() {
      processing = true;
    });

    String firstName = firstNameTextEditController.text;
    String lastName = lastNameTextEditController.text;

    if (educationLevel == null || firstName.isEmpty || lastName.isEmpty) {
      ToastUtils.showSystemToast("请先输入内容哦".tr);
      setState(() {
        processing = false;
      });
      return;
    }

    int eduId = 0;
    educationInfoMap.forEach((key, value) {
      if (value == educationLevel) {
        eduId = key;
      }
    });

    await userService.userProfileUpdate(firstName, lastName, eduId);
    await userAction.updateUserInfo();

    ToastUtils.showSystemToast("修改成功".tr);

    setState(() {
      processing = false;
    });
  }

  @override
  void dispose() {
    firstNameTextEditController.dispose();
    lastNameTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Title Bar
          Container(
            height: 48.w,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 8.w),
            child: Stack(
              children: [
                Positioned(
                    left: 24.w,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: UiResource.primaryBlack,
                        size: 36,
                      ),
                    )),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Main Content
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  alignment: Alignment.centerLeft,
                  child: const Text("First name"),
                ),
                Container(
                  height: 40.w,
                  margin: EdgeInsets.only(top: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                          color: UiResource.primaryGrey, width: 1.w)),
                  child: Center(
                    child: TextField(
                      controller: firstNameTextEditController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "First name *",
                        hintStyle: TextStyle(color: UiResource.primaryGrey),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  alignment: Alignment.centerLeft,
                  child: const Text("Last name"),
                ),
                Container(
                  height: 40.w,
                  margin: EdgeInsets.only(top: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                          color: UiResource.primaryGrey, width: 1.w)),
                  child: Center(
                    child: TextField(
                      controller: lastNameTextEditController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Last name",
                        hintStyle: TextStyle(color: UiResource.primaryGrey),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  alignment: Alignment.centerLeft,
                  child: const Text("Education Level"),
                ),
                Container(
                  height: 40.w,
                  margin: EdgeInsets.only(top: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                          color: UiResource.primaryGrey, width: 1.w)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: educationLevel,
                      hint: Text(
                        'Education Level',
                        style: TextStyle(color: UiResource.primaryGrey),
                      ),
                      buttonStyleData: const ButtonStyleData(
                        width: double.infinity,
                      ),
                      dropdownStyleData: DropdownStyleData(maxHeight: 180.w),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40.w,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          educationLevel = value;
                        });
                      },
                      items: educationLevelItems
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      color: UiResource.primaryGrey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onUpdate,
                  child: Container(
                    height: 40.w,
                    width: Get.width,
                    margin: EdgeInsets.only(top: 24.w),
                    decoration: ShapeDecoration(
                      color: UiResource.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: processing
                          ? Center(
                              child: SizedBox(
                                width: 15.w,
                                height: 15.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Update Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const UserAccountClosePage());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 32.w),
                    child: Text(
                      "注销账号".tr,
                      style:
                          TextStyle(color: UiResource.primaryRed, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
