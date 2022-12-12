import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/controllers/user_controller.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:get/get.dart';

import '../repos/shifts_repo.dart';

class ShiftsController extends GetxController {
  Rx<ShiftModel?> currentShift = (null as ShiftModel?).obs;
  RxList<ShiftModel> currentShifts = <ShiftModel>[].obs;
  //target shift
    Rx<ShiftModel?> targetShift = (null as ShiftModel?).obs;

  UserController get userController {
    return Get.find<UserController>();
  }

  TasksController get tasksController {
    return Get.find<TasksController>();
  }

  Future<void> getMyShift() async {
    List<ShiftModel> todayShifts = await ShiftRepo().getShifts();
    currentShifts.value = todayShifts;
    currentShift.value = await ShiftRepo().getAndAssignShift(todayShifts, userController.currentUser.value!.id!);
  }
}
