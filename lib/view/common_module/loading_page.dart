import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("public/asset/lottie/round_loading.json", width: 100.w),
          //目的是让上面的Lottie处于Y轴正中位置
          Container(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
