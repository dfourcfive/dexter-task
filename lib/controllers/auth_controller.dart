import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/auth_views/auth_view.dart';
import '../views/navigation_view.dart';

//handle auth and loading the data
class AuthController extends GetxController {
  UserController get userController {
    return Get.find<UserController>();
  }

  TasksController get tasksController {
    return Get.find<TasksController>();
  }

  ShiftsController get shiftsController {
    return Get.find<ShiftsController>();
  }

  Future<void> init() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Get.offNamed(AuthView.id);
    } else {
      await loadAppData();
      Get.offNamed(NavigationView.id);
    }
  }

  Future<void> loadAppData() async {
    await userController.getCurrentUser();
    await shiftsController.getMyShift();
    await tasksController.getMyTasks();
  }
}
