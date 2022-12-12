import 'dart:math';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'gradients_generator/core/flutter_gradients_names.dart';
import 'gradients_generator/flutter_gradients.dart';

class ShiftItemWidget extends StatelessWidget {
  int index;
  Animation<double> itemAnimation;
  ShiftModel item;

  ShiftItemWidget({Key? key, required this.index, required this.itemAnimation, required this.item}) : super(key: key);
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final ShiftsController shiftsController = Get.find<ShiftsController>();

    //
    //
    return SizeFadeTransition(
        sizeFraction: 0.7,
        curve: Curves.easeInOut,
        animation: itemAnimation,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.7)),
                    child: Image.asset(
                      'assets/images/shift.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration:
                                  BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.7)),
                              child: Text(
                                Jiffy(item.shift_date).jm,
                              )),
                        ],
                      ),
                      Container(height: 0.01.sh),
                      Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white.withOpacity(0.7)),
                          child: Text(
                            item.type.name.split('_').first,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
