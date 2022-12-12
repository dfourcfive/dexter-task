import 'dart:math';
import 'dart:ui';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:dexter_task/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../controllers/tasks_controller.dart';
import '../repos/tasks_repo.dart';
import 'gradients_generator/core/flutter_gradients_names.dart';
import 'gradients_generator/flutter_gradients.dart';

class TaskItemWidget extends StatelessWidget {
  bool enable;
  int index;
  Animation<double> itemAnimation;
  TaskModel item;
  TaskItemWidget({Key? key, required this.index, required this.itemAnimation, required this.item, this.enable = true}) : super(key: key);
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();

    return SizeFadeTransition(
        sizeFraction: 0.7,
        curve: Curves.easeInOut,
        animation: itemAnimation,
        child: SwipeActionCell(
          key: ObjectKey(index),
          trailingActions: <SwipeAction>[
            SwipeAction(

                /// this is the same as iOS native
                performsFirstActionWithFullSwipe: true,
                title: "Assign to next shift",
                onTap: (CompletionHandler handler) async {
                  //Assign it to the next shift
                  if (enable) {
                    tasksController.assignToNextShift(item, index);

                    await handler(true);
                  }
                },
                color: Colors.red),
          ],
          child: Handle(
            delay: const Duration(milliseconds: 1000),
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.0),
              width: 0.95.sw,
              height: 0.14.sh,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: FlutterGradients.findByName(FlutterGradientNames.values[_random.nextInt(FlutterGradientNames.values.length)]),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.7)),
                      child: Image.asset(
                        'assets/images/patient.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration:
                                      BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.7)),
                                  child: Text(
                                    item.title,
                                  )),
                              enable
                                  ? SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor: Colors.white, // Your color
                                        ),
                                        child: Checkbox(
                                          activeColor: Colors.white,
                                          // Color of your check mark
                                          checkColor: Colors.black,
                                          //   fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: item.isComplete,
                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                          onChanged: (bool? value) {
                                            if (value != null) {
                                              tasksController
                                                  .currentTasks[tasksController.currentTasks.indexWhere((e) => e.id == item.id)].isComplete = value;
                                              tasksController.currentTasks.refresh();
                                              TasksRepo().updateTask(item);
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          Container(height: 0.01.sh),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              width: 0.65.sw,
                              decoration:
                                  BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.7)),
                              child: Text(
                                item.description,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
