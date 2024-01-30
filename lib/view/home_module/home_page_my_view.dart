import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/bottom_sheet/upgrade_plan_bottom_sheet.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';

class HomePageMyView extends StatefulWidget {
  const HomePageMyView({super.key});

  @override
  State<HomePageMyView> createState() => _HomePageMyViewState();
}

class _HomePageMyViewState extends State<HomePageMyView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Get.mediaQuery.viewPadding.top + 10, bottom: 15.w),
              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 87.w),
              children: [
                Container(
                  width: Get.width,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Account',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          Image(
                              width: 16.w,
                              height: 16.w,
                              image: const AssetImage(
                                  "public/asset/icon/edit.png"))
                        ],
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 32.w,
                              height: 32.w,
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.w,
                                      color: const Color(0x6CD8D8D8))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                // ignore: prefer_const_constructors
                                child: Image(
                                  image: const AssetImage(
                                      "public/asset/icon/home_page_logo_icon.png"),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 8.w),
                            child: Text(
                              '${userController.userFirstName} ${userController.userLastName}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: Get.width,
                        height: 0.5,
                        margin: EdgeInsets.only(top: 15.w),
                        color: const Color(0xFFDDDDDD),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0A0A0A),
                              ),
                            ),
                            Text(
                              '${userController.sub}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0A),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Education',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0A0A0A),
                              ),
                            ),
                            Text(
                              '${userController.education}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0A),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Container(
                  width: Get.width,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Account',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0.09,
                            ),
                          ),
                          Image(
                              width: 16.w,
                              height: 16.w,
                              image: const AssetImage(
                                  "public/asset/icon/information.png"))
                        ],
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Current plan',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.w),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Free Plan',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.17,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      Row(
                        children: [
                          Image(
                              width: 20.w,
                              height: 20.w,
                              image: const AssetImage(
                                  "public/asset/icon/coin.png")),
                          SizedBox(
                            width: 12.w,
                          ),
                          const Text(
                            'Pro',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5B00CD),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 162.w,
                            height: 16.w,
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                                color: const Color(0xFFE1D3FF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFB272F3),
                                    width: 2.w)),
                            child: Row(
                              children: [
                                Container(
                                  width: 32.w,
                                  height: 16.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8222F8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          '2/10',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8222F8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      Row(
                        children: [
                          Image(
                              width: 20.w,
                              height: 20.w,
                              image: const AssetImage(
                                  "public/asset/icon/diamond.png")),
                          SizedBox(
                            width: 12.w,
                          ),
                          const Text(
                            'Max',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5B00CD),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 162.w,
                            height: 16.w,
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                                color: const Color(0xFFE1D3FF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFB272F3),
                                    width: 2.w)),
                            child: Row(
                              children: [
                                Container(
                                  width: 81.w,
                                  height: 16.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8222F8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          '1/2',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8222F8),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.w,
                        width: Get.width,
                        margin: EdgeInsets.only(top: 16.w),
                        decoration: ShapeDecoration(
                          color: UiResource.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: const Text(
                            'Upgrade Plan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Container(
                        width: Get.width,
                        height: 0.5,
                        margin: EdgeInsets.only(top: 15.w),
                        color: const Color(0xFFDDDDDD),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 24.w),
                        child: const Text(
                          'Coins by invitation',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.w),
                        child: Row(
                          children: [
                            Image(
                                width: 20.w,
                                height: 20.w,
                                image: const AssetImage(
                                    "public/asset/icon/coin.png")),
                            SizedBox(
                              width: 12.w,
                            ),
                            const Text(
                              'Pro',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF5B00CD),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              '16',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF333333),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 16.w),
                        child: const Text(
                          'Invite a friend to get more chats',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2B95EB),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(const UpgradePlanBottomSheet());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.w),
                    padding: EdgeInsets.all(16.w),
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
                    child: Row(
                      children: [
                        Image(
                            width: 24.w,
                            height: 24.w,
                            image: const AssetImage(
                                "public/asset/icon/payment.png")),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Text(
                          'Subscription & Payment ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: UiResource.primaryBlack,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.w),
                  padding: EdgeInsets.all(16.w),
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
                  child: Row(
                    children: [
                      Image(
                          width: 24.w,
                          height: 24.w,
                          image: const AssetImage(
                              "public/asset/icon/international.png")),
                      SizedBox(
                        width: 12.w,
                      ),
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'English',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666666),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: UiResource.primaryBlack,
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      );
    });
  }
}
