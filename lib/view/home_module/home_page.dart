import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/navigation_index_controller.dart';
import 'package:mathgptpro_mclient_flutter/view/home_module/home_page_my_view.dart';
import 'package:mathgptpro_mclient_flutter/view/home_module/home_page_question_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MainBottomNavigationBar(),
      body: GetBuilder<NavigationIndexController>(
        builder: (navigationIndexController) {
          return IndexedStack(
            index: navigationIndexController.currentMainNavigationIndex.index,
            children: const [HomePageQuestionView(), HomePageMyView()],
          );
        },
      ),
    );
  }
}
