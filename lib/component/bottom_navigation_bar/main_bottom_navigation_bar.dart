import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/navigation_index_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/image_select_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/question_module/question_answer_page.dart';

/// 底部导航栏
class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationIndexController>(
        builder: (mainNavigationIndexController) {
      return BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.theme.bottomAppBarTheme.color,
        items: [
          BottomNavigationBarItem(
              icon: Image(
                  width: 48.w,
                  height: 48.w,
                  image: mainNavigationIndexController
                              .currentMainNavigationIndex ==
                          MainNavigationIndexEnum.home
                      ? const AssetImage(
                          "public/asset/icon/bottom_navigation_bar_home_page_selected_icon.png")
                      : const AssetImage(
                          "public/asset/icon/bottom_navigation_bar_home_page_unselect_icon.png")),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image(
                  width: 48.w,
                  height: 48.w,
                  image: const AssetImage(
                      "public/asset/icon/bottom_navigation_bar_chat_page_unselect_icon.png")),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: Image(
                  width: 48.w,
                  height: 48.w,
                  image: const AssetImage(
                      "public/asset/icon/bottom_navigation_bar_camera_page_unselect_icon.png")),
              label: "Camera"),
          BottomNavigationBarItem(
              icon: Image(
                  width: 48.w,
                  height: 48.w,
                  image: mainNavigationIndexController
                              .currentMainNavigationIndex ==
                          MainNavigationIndexEnum.profile
                      ? const AssetImage(
                          "public/asset/icon/bottom_navigation_bar_profile_page_selected_icon.png")
                      : const AssetImage(
                          "public/asset/icon/bottom_navigation_bar_profile_page_unselect_icon.png")),
              label: "Profile")
        ],
        currentIndex:
            mainNavigationIndexController.currentMainNavigationIndex.index,
        onTap: (index) {
          switch (index) {
            case 0:
              mainNavigationIndexController.currentMainNavigationIndex =
                  MainNavigationIndexEnum.home;
              break;
            case 1:
              Get.to(() => const QuestionAnswerPage(sessionUuid: null));
              break;
            case 2:
              ImageSelectUtils.cameraImageSelect(true);
              break;
            case 3:
              mainNavigationIndexController.currentMainNavigationIndex =
                  MainNavigationIndexEnum.profile;
              break;
          }
        },
      );
    });
  }
}
