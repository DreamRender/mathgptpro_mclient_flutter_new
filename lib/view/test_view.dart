import 'package:flutter/material.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MaterialButton(
            onPressed: () {},
            color: UiResource.primaryBlue,
            child: const Text("data"),
          )
        ],
      ),
    );
  }
}
