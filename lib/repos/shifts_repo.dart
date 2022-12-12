import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:dexter_task/models/task_model.dart';

class ShiftRepo {
  static final ShiftRepo _instance = ShiftRepo._internal();
  ShiftRepo._internal();
  factory ShiftRepo() => _instance;

  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<List<ShiftModel>> getShifts() async {
    List<ShiftModel> result = [];
    final snapshots = await instance.collection('shifts').where('shift_date').get();
    for (var element in snapshots.docs) {
      if (element.exists) {
        ShiftModel shiftModel = ShiftModel.fromJson(element.data());
        shiftModel.id = element.id;
        result.add(shiftModel);
      }
    }
    return result;
  }

  Future<ShiftModel> getAndAssignShift(List<ShiftModel> shifts, String nurse_id) async {
    DateTime now = DateTime.now();
    ShiftModel currentShift;
    DateTime today = DateTime(now.year, now.month, now.day);
    //this should return more than three shifts for a day (given that each day has three shifts) *3
    List<ShiftModel> todayShifts = shifts.where((e) => (e.shift_date.compareTo(today) == 0)).toList();
    if (now.hour >= 6 && now.hour <= 14) {
      currentShift = todayShifts.firstWhere((element) => element.type == ShiftType.MORNING_SHIFT);
    } else if (now.hour >= 14 && now.hour <= 21) {
      currentShift = todayShifts.firstWhere((element) => element.type == ShiftType.EVENING_SHIFT);
    } else {
      currentShift = todayShifts.firstWhere((element) => element.type == ShiftType.NIGHT_SHIFT);
    }
    await assignShift(currentShift, nurse_id);

    return currentShift;
  }

  Future<void> assignShift(ShiftModel shift, String nurse_id) async {
    final taskDoc = await instance.collection('shifts').doc(shift.id);
    //we can create copyWith function and use it here , many ways to do this better
    shift.person_in_charge_id = nurse_id;

    await taskDoc.set(shift.toJson());
  }
}
