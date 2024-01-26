import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/payment_moudule/payment_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtil().statusBarHeight,
          ),
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
                    'Summary',
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
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: 31.w, horizontal: 24.w),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.w),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x140054A7),
                      blurRadius: 7,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          transform: Matrix4.translationValues(0, -2, 0),
                          child: Image(
                              width: 24.w,
                              height: 24.w,
                              image: const AssetImage(
                                  "public/asset/icon/home-page-free-plan-icon.png")),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const Text(
                          'Free Plan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Free',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: UiResource.primaryPurple,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1.w,
                      width: Get.width,
                      margin: EdgeInsets.only(top: 21.w),
                      color: const Color(0xFFDDDDDD),
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    Row(
                      children: [
                        Image(
                            width: 24.w,
                            height: 24.w,
                            color: const Color(0xFF666666),
                            image:
                                const AssetImage("public/asset/icon/coin.png")),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text(
                          'Pro',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const Spacer(),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '10',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              TextSpan(
                                text: '/mo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    Row(
                      children: [
                        Image(
                            width: 24.w,
                            height: 24.w,
                            color: const Color(0xFF666666),
                            image: const AssetImage(
                                "public/asset/icon/diamond.png")),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const Spacer(),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '2',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              TextSpan(
                                text: '/mo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 18.w),
                  child: Image(
                      width: 44.w,
                      height: 44.w,
                      image: const AssetImage(
                          "public/asset/icon/summary_page_arrow_icon.png")),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18.w),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.w),
                decoration: ShapeDecoration(
                  color: UiResource.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x140054A7),
                      blurRadius: 7,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          transform: Matrix4.translationValues(0, -2, 0),
                          child: Image(
                              width: 24.w,
                              height: 24.w,
                              color: Colors.white,
                              image: const AssetImage(
                                  "public/asset/icon/home-page-premuim-plan-icon.png")),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const Text(
                          'Premium plan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Annual',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            const Text(
                              '\$99.88/year',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFE1D3FF),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 1.w,
                      width: Get.width,
                      margin: EdgeInsets.only(top: 21.w),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    Row(
                      children: [
                        Image(
                            width: 24.w,
                            height: 24.w,
                            color: Colors.white,
                            image:
                                const AssetImage("public/asset/icon/coin.png")),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text(
                          'Pro',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '1000',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: '/mo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    Row(
                      children: [
                        Image(
                            width: 24.w,
                            height: 24.w,
                            color: Colors.white,
                            image: const AssetImage(
                                "public/asset/icon/diamond.png")),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '100',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: '/mo',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 23.w),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.w),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF3F3F3),
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.5, color: Color(0xFF666666)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        width: 24.w,
                        height: 24.w,
                        color: UiResource.primaryBlue,
                        image: const AssetImage(
                            "public/asset/icon/information.png")),
                    SizedBox(
                      height: 12.w,
                    ),
                    const Text(
                      'Your subscription plan will undergo the change once the current subscription period concludes.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF666666),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PaymentPage());
                },
                child: Container(
                  height: 40.w,
                  width: Get.width,
                  margin: EdgeInsets.only(top: 30.w),
                  decoration: ShapeDecoration(
                    color: UiResource.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: const Text(
                      'Go to Payment',
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
          ))
        ],
      ),
    );
  }
}
