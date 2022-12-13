import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/controllers/user_controller.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:dexter_task/models/task_model.dart';
import 'package:dexter_task/repos/tasks_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  RxList<TaskModel> currentTasks = <TaskModel>[].obs;

  //Form fields controllers and keys
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  //
  UserController get userController {
    return Get.find<UserController>();
  }

  ShiftsController get shiftsController {
    return Get.find<ShiftsController>();
  }

  Future<void> getMyTasks() async {
    currentTasks.value = await TasksRepo().getTasksByShiftId(shiftsController.currentShift.value!.id!);
  }

  Future<void> addTask(TaskModel taskModel, String? shiftId) async {
    //if its not null this mean the task if for another shift
    if (shiftId != null) {
      taskModel.shift_id = shiftsController.targetShift.value!.id!;
      final result = await TasksRepo().createTask(taskModel);
      // currentTasks.add(result);
    } else {
      //the task is for the current shift
      taskModel.shift_id = shiftsController.currentShift.value!.id!;
      final result = await TasksRepo().createTask(taskModel);
      currentTasks.add(result);
    }
  }

  Future<void> addTaskToShift(TaskModel taskModel, String shift_id) async {
    final result = await TasksRepo().createTask(taskModel);
  }
  //assign a task to the next the next shift
  //so if the current shift is in the evening the task should passed to a shift in the night
  //if the current shift is in the night => task should be passed to a shift in the morning
  // else it passed to the next day's shift

  //this is just a small demonstration of the code
  //it still lack domain knowledge
  Future<void> assignToNextShift(TaskModel taskModel, int index) async {
    try {
      ShiftModel nextShift;
      ShiftModel currentShift = shiftsController.currentShift.value!;
      if (currentShift.type == ShiftType.EVENING_SHIFT) {
        nextShift = shiftsController.currentShifts.firstWhere((e) => e.type == ShiftType.NIGHT_SHIFT);
      } else if (currentShift.type == ShiftType.NIGHT_SHIFT) {
        nextShift = shiftsController.currentShifts.firstWhere((e) => e.type == ShiftType.MORNING_SHIFT);
      } else {
        nextShift = shiftsController.currentShifts.firstWhere((e) => e.type == ShiftType.EVENING_SHIFT);
      }
      await TasksRepo().assingToNextShift(taskModel, nextShift);
      currentTasks.removeAt(index);
    } catch (e) {
      //TODO
      //Handle if next shift not found
    }
  }
}
