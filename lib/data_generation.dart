import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_task/models/resident_model.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:dexter_task/models/task_model.dart';

// a function to generate fake shifts and tasks
// no assigning here
// assignment can be done when we can retrieve a current available shift based on today's date and time
Future<void> generateShifts() async {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final _random = new Random();

  for (var i = 0; i < 200; i++) {
    var today = DateTime(2022, 12, 12);

    for (var i = 0; i < 3; i++) {
      ShiftType type = i == 0
          ? ShiftType.NIGHT_SHIFT
          : i == 1
              ? ShiftType.MORNING_SHIFT
              : ShiftType.EVENING_SHIFT;
      ShiftModel shiftModel = ShiftModel(person_in_charge_id: '', type: type, shift_date: today);
      var doc = await instance.collection('shifts').add(shiftModel.toJson());
      //we generate tasks for each one
      for (var i = 0; i < 5; i++) {
        ResidentModel residentModel = ResidentModel(fullName: 'random_name', room: _random.nextInt(1000), age: _random.nextInt(100));
        var residentDoc = await instance.collection('residents').add(residentModel.toJson());

        TaskModel taskModel = TaskModel(
            description: 'this is a description for a task',
            isComplete: false,
            title: 'Task title',
            owner_id: '',
            shift_id: doc.id,
            resident_id: residentDoc.id);
        await instance.collection('tasks').add(taskModel.toJson());
      }
    }
    today.add(Duration(days: 1));
  }
}
