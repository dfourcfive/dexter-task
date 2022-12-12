import 'dart:ui';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/repos/tasks_repo.dart';
import 'package:dexter_task/views/home_views/tasks_views/add_task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:math';
import '../../constants/colors.dart';
import '../../models/task_model.dart';
import '../../widgets/gradients_generator/core/flutter_gradients_names.dart';
import '../../widgets/gradients_generator/flutter_gradients.dart';
import '../../widgets/task_item.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(
              AddTaskView.id,
            );
          }),
      body: Obx(() {
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
                    Jiffy(DateTime.now()).MMMMEEEEd,
                    style: TextStyle(fontSize: 23.sp, color: const Color(0xFF0E0E11)),
                  )),
              Container(
                height: 20.h,
              ),
              Expanded(
                child: ImplicitlyAnimatedReorderableList<TaskModel>(
                  // The current items in the list.
                  items: tasksController.currentTasks.value,
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
      }),
    );
  }
}

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}
