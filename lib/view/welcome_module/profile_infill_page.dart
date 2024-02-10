import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/refocus_component.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/login_page.dart';

class ProfileInfillPage extends StatefulWidget {
  const ProfileInfillPage({super.key});

  @override
  State<ProfileInfillPage> createState() => _ProfileInfillPageState();
}

class _ProfileInfillPageState extends State<ProfileInfillPage> {
  bool isPasswordVisible = false;

  final List<String> educationLevelItems = [
    'Preschool',
    'Kindergarten',
    'Elementary School',
    'Middle School',
    'High School',
    'Vocational / Trade School',
    'Associate Degree',
    'Undergraduate (Bachelor)',
    'Postgraduate (Masters)',
    'Doctorate (PhD)',
    'Postdoctoral',
  ];
  String? educationLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefocusComponent(
        child: Stack(
          children: [
            Container(
              height: 240.w,
              width: Get.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "public/asset/background/login_page_background.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 88.w, left: 24.w),
              child: Image(
                width: 63.w,
                height: 67.w,
                image:
                    const AssetImage("public/asset/icon/login_page_logo.png"),
              ),
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 220.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 64.w),
                    child: Text(
                      'Customize your \nexperience',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.w),
                    child: Text(
                      'Tell us about your education level so that we can provide better services.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    height: 40.w,
                    margin: EdgeInsets.only(top: 24.w),
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
                    onTap: () {
                      Get.offAll(() => const LoginPage());
                    },
                    child: Container(
                      height: 40.w,
                      margin: EdgeInsets.only(top: 160.w),
                      decoration: ShapeDecoration(
                        color: UiResource.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: const Text(
                          'Complete',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
