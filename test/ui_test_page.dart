import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mathgptpro_mclient_flutter/component/bottom_sheet/upgrade_plan_bottom_sheet.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: UiTestPage(),
    );
  }
}

class UiTestPage extends StatefulWidget {
  const UiTestPage({super.key});

  @override
  State<UiTestPage> createState() => _UiTestPageState();
}

class _UiTestPageState extends State<UiTestPage> {
  Future<void> signinWithGoogle() async {
    const GOOGLE_CLIENT_DEV_KEY =
        '1074402275475-27sj1mpskdamepksb4nftihk60ndfg07.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: GOOGLE_CLIENT_DEV_KEY,
      scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'openid',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
    try {
      final googleUserAccount = await googleSignIn.signIn();
      final googleAuth = await googleUserAccount?.authentication;
      if (googleAuth != null) {
        log(googleAuth.idToken.toString());
        print(googleAuth.accessToken.toString());
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MaterialButton(
            onPressed: () {
              Get.bottomSheet(const UpgradePlanBottomSheet());
            },
            child: const Text("Upgrade Your Plan Bottom Sheet"),
          )
        ],
      ),
    );
  }
}
