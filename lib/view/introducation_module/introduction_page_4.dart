import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/home_module/home_page.dart';

class IntroductionPage4 extends StatelessWidget {
  const IntroductionPage4({super.key});

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
                      width: 370.w,
                      height: 280.w,
                      image: const AssetImage(
                          "public/asset/icon/introduction_page_icon_4.png")),
                ),
                Container(
                  width: 326.w,
                  margin: EdgeInsets.only(top: 62.w),
                  child: SizedBox(
                    width: 327,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'We’d like to give you ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: UiResource.primaryBlack,
                            ),
                          ),
                          TextSpan(
                            text: '10  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: UiResource.primaryPurple,
                            ),
                          ),
                          WidgetSpan(
                              child: Container(
                            transform: Matrix4.translationValues(0, 2, 0),
                            child: Image(
                                width: 24.w,
                                height: 24.w,
                                image: const AssetImage(
                                    "public/asset/icon/coin.png")),
                          )),
                          TextSpan(
                            text: '  and ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: UiResource.primaryBlack,
                            ),
                          ),
                          TextSpan(
                            text: '2  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: UiResource.primaryPurple,
                            ),
                          ),
                          WidgetSpan(
                              child: Container(
                            transform: Matrix4.translationValues(0, 2, 0),
                            child: Image(
                                width: 24.w,
                                height: 24.w,
                                image: const AssetImage(
                                    "public/asset/icon/diamond.png")),
                          )),
                          TextSpan(
                            text:
                                '  to get started. \n\nClaim your reward below!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: UiResource.primaryBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 25.w,
            bottom: 120.w,
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
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => const HomePage());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: const Text(
                    'Claim Reward',
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
          ),
          Positioned(
            left: 35.w,
            bottom: 40.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: UiResource.primaryBlue),
                  ),
                ),
                Container(
                  width: 4.w,
                  height: 4.w,
                  margin: EdgeInsets.only(left: 173.w),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFC9E8FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Container(
                  width: 4.w,
                  height: 4.w,
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFFC9E8FF),
                      borderRadius: BorderRadius.all(Radius.circular(6.r))),
                ),
                Container(
                  width: 40.w,
                  height: 4.w,
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: ShapeDecoration(
                    color: UiResource.primaryBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24.w),
                  child: Image(
                      width: 20.w,
                      height: 24.w,
                      image: const AssetImage(
                          "public/asset/icon/icon_gift_box.png")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
