import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/payment_moudule/summary_page.dart';

class UpgradeListPage extends StatefulWidget {
  const UpgradeListPage({super.key});

  @override
  State<UpgradeListPage> createState() => _UpgradeListPageState();
}

class _UpgradeListPageState extends State<UpgradeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            top: Get.mediaQuery.viewPadding.top, left: 28.w, right: 28.w),
        child: Column(
          children: [
            GestureDetector(
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
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(bottom: 64.w),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    height: 32.w,
                    width: 32.w,
                    image:
                        const AssetImage("public/asset/icon/upgrade_icon.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.w),
                  child: const Text(
                    'Upgrade to lock more AI chats and benefits',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 15.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE1D3FF)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current plan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666),
                        ),
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Free Plan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            transform: Matrix4.translationValues(0, -1, 0),
                            child: Image(
                                width: 15.w,
                                height: 15.w,
                                image: const AssetImage(
                                    "public/asset/icon/home-page-free-plan-icon.png")),
                          ),
                          const Spacer(),
                          Image(
                              width: 16.w,
                              height: 16.w,
                              image: const AssetImage(
                                  "public/asset/icon/coin.png")),
                          Container(
                            margin: EdgeInsets.only(left: 10.w),
                            child: Text(
                              '10',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UiResource.primaryBlack,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24.w),
                            child: Image(
                                width: 16.w,
                                height: 16.w,
                                image: const AssetImage(
                                    "public/asset/icon/diamond.png")),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w),
                            child: Text(
                              '2',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UiResource.primaryBlack,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Text(
                        '10 Coins and 2 diamonds will be replenished \n monthly.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: UiResource.primaryBlack,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 28.w),
                  child: Row(
                    children: [
                      Container(
                        width: 159.w,
                        height: 40.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: const ShapeDecoration(
                          color: Color(0xFFE1D3FF),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFE1D3FF)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              transform: Matrix4.translationValues(0, -2, 0),
                              child: const Icon(
                                Icons.check_outlined,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Text(
                              'Starter Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF001D35),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 159.w,
                        height: 40.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            const Text(
                              'Premium Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF001D35),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 375.w,
                  width: Get.width,
                  margin: EdgeInsets.only(top: 20.w),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 241.w,
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        padding: EdgeInsets.all(24.w),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF8222F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x260054A7),
                              blurRadius: 10,
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
                                const Text(
                                  'Annual Plan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFF3F3F3),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image(
                                      width: 12.w,
                                      height: 12.w,
                                      image: const AssetImage(
                                          "public/asset/icon/best_deal.png"),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    const Text(
                                      'Best Deal',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFF8F8F8),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 14.w,
                            ),
                            SizedBox(
                              width: 133.w,
                              height: 35.w,
                              child: Stack(
                                children: [
                                  const Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFF8F8F8),
                                        ),
                                      )),
                                  Positioned(
                                      top: -8.w,
                                      left: 15.w,
                                      child: const Text(
                                        '7.99',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFF8F8F8),
                                        ),
                                      )),
                                  const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Text(
                                        '/ month',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFF8F8F8),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 18),
                              child: Row(
                                children: [
                                  const Text(
                                    '\$199.99/year',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.w),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFB271F3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save 15%',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFF8F8F8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 32.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Full access to all feature',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '100',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' coins per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '10',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' diamonds per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Cancel at any time',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const SummaryPage());
                              },
                              child: Center(
                                child: Container(
                                  width: Get.width,
                                  height: 40.w,
                                  margin: EdgeInsets.only(top: 13.w),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 10),
                                    child: const Text(
                                      'Buy now',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF339AF0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Container(
                        width: 241.w,
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        padding: EdgeInsets.all(24.w),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x260054A7),
                              blurRadius: 10,
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
                                const Text(
                                  'Seasonly Plan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image(
                                      width: 12.w,
                                      height: 12.w,
                                      image: const AssetImage(
                                          "public/asset/icon/most_popular.png"),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    const Text(
                                      'Most Popular',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 14.w,
                            ),
                            SizedBox(
                              width: 133.w,
                              height: 35.w,
                              child: Stack(
                                children: [
                                  const Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Positioned(
                                      top: -8.w,
                                      left: 15.w,
                                      child: const Text(
                                        '7.99',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )),
                                  const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Text(
                                        '/ month',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 18),
                              child: Row(
                                children: [
                                  const Text(
                                    '\$22.99/season',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.w),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFB271F3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save 10%',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 32.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Full access to all feature',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '100',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' coins per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '10',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' diamonds per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Cancel at any time',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: Get.width,
                                height: 40.w,
                                margin: EdgeInsets.only(top: 13.w),
                                decoration: ShapeDecoration(
                                  color: UiResource.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  child: const Text(
                                    'Buy now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Container(
                        width: 241.w,
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        padding: EdgeInsets.all(24.w),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x260054A7),
                              blurRadius: 10,
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
                                const Text(
                                  'Monthly Plan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image(
                                      width: 12.w,
                                      height: 12.w,
                                      image: const AssetImage(
                                          "public/asset/icon/good_start.png"),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    const Text(
                                      'Good Start',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 14.w,
                            ),
                            SizedBox(
                              width: 133.w,
                              height: 35.w,
                              child: Stack(
                                children: [
                                  const Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Positioned(
                                      top: -8.w,
                                      left: 15.w,
                                      child: const Text(
                                        '8.99',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      )),
                                  const Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Text(
                                        '/ month',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 18),
                              child: Row(
                                children: [
                                  const Text(
                                    '',
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 8.w),
                                    child: const Text(
                                      ' ',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 32.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Full access to all feature',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '100',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' coins per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '10',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' diamonds per month',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.w,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                          width: 16.w,
                                          height: 16.w,
                                          color: UiResource.primaryBlue,
                                          image: const AssetImage(
                                              "public/asset/icon/check.png")),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Text(
                                        'Cancel at any time',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: Get.width,
                                height: 40.w,
                                margin: EdgeInsets.only(top: 13.w),
                                decoration: ShapeDecoration(
                                  color: UiResource.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  child: const Text(
                                    'Buy now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  child: const Text(
                    'Before proceeding to payment, you have the option to apply a coupon code for potential discounts or benefits.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
