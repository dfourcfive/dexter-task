import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/controllers/user_controller.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation_view.dart';

class AuthView extends StatelessWidget {
  static const id = '/login-view';

  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final ShiftsController shiftsController = Get.find<ShiftsController>();
    final TasksController tasksController = Get.find<TasksController>();

    return SignInScreen(
      providers: [EmailAuthProvider()],
      //showAuthActionSwitch: false,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          await userController.getCurrentUser();
          await shiftsController.getMyShift();
          await tasksController.getMyTasks();
          Get.offNamed(NavigationView.id);
        }),
      ],
    );
  }
}
