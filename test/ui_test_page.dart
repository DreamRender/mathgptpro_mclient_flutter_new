import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/bottom_sheet/upgrade_plan_bottom_sheet.dart';

class UiTestPage extends StatefulWidget {
  const UiTestPage({super.key});

  @override
  State<UiTestPage> createState() => _UiTestPageState();
}

class _UiTestPageState extends State<UiTestPage> {
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
