import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dexter_task/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationView extends StatelessWidget {
  static const id = '/home-view';
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();

    return Obx(() {
      return Scaffold(
          body: navigationController.children[navigationController.currentIndex.value],
          bottomNavigationBar: CustomNavigationBar(
            iconSize: 30.0,
            selectedColor: const Color(0xff040307),
            strokeColor: const Color(0x30040307),
            unSelectedColor: const Color(0xffacacac),
            backgroundColor: Colors.white,
            items: [
              CustomNavigationBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Icons.task_alt),
                title: const Text("Tasks"),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Icons.today_outlined),
                title: const Text("Shifts"),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Me"),
              ),
            ],
            currentIndex: navigationController.currentIndex.value,
            onTap: (index) {
              navigationController.currentIndex.value = index;
            },
          ));
    });
  }
}
