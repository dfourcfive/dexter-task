import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_task/models/shift_model.dart';
import 'package:dexter_task/models/task_model.dart';

class TasksRepo {
  static final TasksRepo _instance = TasksRepo._internal();
  TasksRepo._internal();
  factory TasksRepo() => _instance;

  FirebaseFirestore instance = FirebaseFirestore.instance;

  //
  Future<TaskModel> createTask(TaskModel taskModel) async {
    final result = await instance.collection('tasks').add(taskModel.toJson());
    taskModel.id = result.id;
    return taskModel;
  }

  //
  Future<void> updateTask(TaskModel taskModel) async {
    final taskDoc = instance.collection('tasks').doc(taskModel.id);
    await taskDoc.set(taskModel.toJson());
  }

  //toogle item
  Future<void> toogleItem(TaskModel taskModel) async {
    taskModel.isComplete = !taskModel.isComplete;
    final taskDoc = instance.collection('tasks').doc(taskModel.id);
    taskDoc.set(taskModel.toJson());
  }

  //
  Future<void> assingToNextShift(TaskModel taskModel, ShiftModel shiftModel) async {
    final taskDoc = instance.collection('tasks').doc(taskModel.id);
    taskModel.shift_id = shiftModel.id!;
    await taskDoc.set(taskModel.toJson());
  }

  //get All tasks by current shift
  Future<List<TaskModel>> getTasksByShiftId(String shift_id) async {
    List<TaskModel> result = [];
    var snapshots = await instance.collection('tasks').where('shift_id', isEqualTo: shift_id).get();
    for (var element in snapshots.docs) {
      if (element.exists) {
        TaskModel taskModel = TaskModel.fromJson(element.data());
        taskModel.id = element.id;
        result.add(taskModel);
      }
    }
    return result;
  }
}
