import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/payment_moudule/upgrade_list_page.dart';

class UpgradePlanBottomSheet extends StatelessWidget {
  const UpgradePlanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 24.w),
              shrinkWrap: true,
              children: [
                Center(
                  child: Image(
                    height: 24.w,
                    width: 24.w,
                    image:
                        const AssetImage("public/asset/icon/upgrade_icon.png"),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Text(
                  'Upgrade Your Plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: UiResource.primaryBlack,
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                const Text(
                  "You've utilized all your coins and diamonds. \n Consider upgrading your plan to access additional AI chats and enjoy a range of exclusive benefits!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF49454F),
                  ),
                ),
                SizedBox(
                  height: 32.w,
                ),
                Container(
                  height: 40.w,
                  width: 327.w,
                  decoration: ShapeDecoration(
                    color: UiResource.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const UpgradeListPage());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: const Text(
                        'Upgrade',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
                top: 20.h,
                right: 20.w,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.close,
                      color: UiResource.primaryBlack,
                      size: 24.w,
                    ),
                  ),
                ))
          ],
        ));
  }
}
