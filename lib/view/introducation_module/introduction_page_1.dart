import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/introducation_module/introduction_page_2.dart';

class IntroductionPage1 extends StatelessWidget {
  const IntroductionPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 123.w),
                  child: Image(
                      width: 280.w,
                      height: 280.w,
                      image: const AssetImage(
                          "public/asset/icon/introduction_page_icon_1.png")),
                ),
                Container(
                  width: 326.w,
                  margin: EdgeInsets.only(top: 70.w),
                  child: Text(
                    'Having trouble with math problems? Our AI bot is equipped to assist you in finding the answers you need! ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: UiResource.primaryBlack,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 25.w,
            bottom: 120.w,
            child: GestureDetector(
              onTap: () {
                Get.to(() => const IntroductionPage2(),
                    transition: Transition.rightToLeftWithFade);
              },
              child: Container(
                height: 40.w,
                width: 124.w,
                margin: EdgeInsets.only(top: 80.w),
                decoration: ShapeDecoration(
                  color: UiResource.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: const Text(
                    'Show me how',
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
          )
        ],
      ),
    );
  }
}
