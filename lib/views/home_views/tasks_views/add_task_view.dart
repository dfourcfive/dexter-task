import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/models/task_model.dart';
import 'package:dexter_task/views/home_views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../widgets/common/validators.dart';
import '../../../widgets/form_fields/custom_formfield.dart';

class AddTaskView extends StatelessWidget {
  static const id = '/add-task-view';

  const AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();
    final UserController userController = Get.find<UserController>();
    bool is_for_another_shift = (Get.parameters['shift_id'] != null);

    //
    return Scaffold(
      body: Form(
        key: tasksController.formKey.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomFormField(
                controller: tasksController.titleController.value,
                hintText: 'Title',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z]+|\s"),
                  )
                ],
                validator: AppFormValidation().titleValidator),
            CustomFormField(
                controller: tasksController.descriptionController.value,
                hintText: 'Description',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z]+|\s"),
                  )
                ],
                validator: AppFormValidation().descriptionlValidator),
            ElevatedButton(
              onPressed: () async {
                if (tasksController.formKey.value.currentState!.validate()) {
                  TaskModel taskModel = TaskModel(
                      description: tasksController.descriptionController.value.text,
                      isComplete: false,
                      title: tasksController.titleController.value.text,
                      owner_id: userController.currentUser.value!.id!,
                      resident_id: '', //we pass the id of the resident , not implemented yet
                      shift_id: '' //we'll update the shift_id later
                      );

                  await tasksController.addTask(taskModel, Get.parameters['shift_id']);
                  Get.offAllNamed(HomeView.id);
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
