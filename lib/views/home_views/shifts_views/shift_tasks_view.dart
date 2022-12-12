import 'dart:ui';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:dexter_task/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../constants/colors.dart';
import '../../../controllers/tasks_controller.dart';
import '../../../repos/tasks_repo.dart';
import '../../../widgets/task_item.dart';
import '../tasks_views/add_task_view.dart';

class TasksShiftView extends StatelessWidget {
  static const id = '/tasks-shift-view';

  TasksShiftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();
    final ShiftsController shiftsController = Get.find<ShiftsController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(AddTaskView.id, parameters: {'id': shiftsController.targetShift.value!.id!});
          }),
      body: Obx(() {
        return FutureBuilder(
            future: TasksRepo().getTasksByShiftId(shiftsController.targetShift.value!.id!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              List<TaskModel> data = snapshot.data as List<TaskModel>;

              return Container(
                padding: EdgeInsets.only(top: 0.1.sh),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "Tasks for the shift at ${Jiffy(shiftsController.targetShift.value!.shift_date).MMMMEEEEd}",
                          style: TextStyle(fontSize: 23.sp, color: const Color(0xFF0E0E11)),
                        )),
                    Container(
                      height: 20.h,
                    ),
                    Expanded(
                      child: ImplicitlyAnimatedReorderableList<TaskModel>(
                        // The current items in the list.
                        items: data,
                        // Called by the DiffUtil to decide whether two object represent the same item.
                        // For example, if your items have unique ids, this method should check their id equality.
                        areItemsTheSame: (a, b) => a.id == b.id,
                        onReorderFinished: (item, from, to, newItems) {
                          // Remember to update the underlying data when the list has been
                          // reordered.
                          tasksController.currentTasks
                            ..clear()
                            ..addAll(newItems);
                        },
                        // Called, as needed, to build list item widgets.
                        // List items are only built when they're scrolled into view.
                        itemBuilder: (context, itemAnimation, item, index) {
                          // Specifiy a transition to be used by the ImplicitlyAnimatedList.
                          // See the Transitions section on how to import this transition.
                          return Reorderable(
                              key: ValueKey(index),
                              builder: (context, animation, inDrag) {
                                final t = animation.value;
                                final elevation = lerpDouble(0, 8, t);
                                final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);

                                return TaskItemWidget(
                                  index: index,
                                  itemAnimation: itemAnimation,
                                  item: item,
                                  enable: false,
                                );
                              });
                        },
                        // An optional builder when an item was removed from the list.
                        // If not specified, the List uses the itemBuilder with
                        // the animation reversed.
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
