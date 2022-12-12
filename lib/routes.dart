import 'package:dexter_task/spalsh_view.dart';
import 'package:dexter_task/views/auth_views/auth_view.dart';
import 'package:dexter_task/views/home_views/home_view.dart';
import 'package:dexter_task/views/home_views/shifts_views/shift_tasks_view.dart';
import 'package:dexter_task/views/home_views/tasks_views/add_task_view.dart';
import 'package:dexter_task/views/home_views/tasks_views/task_details_view.dart';
import 'package:dexter_task/views/home_views/tasks_views/update_task_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'views/navigation_view.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(
      name: NavigationView.id,
      page: () => const NavigationView(),
    ),
    GetPage(
      name: SplashView.id,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AuthView.id,
      page: () => const AuthView(),
    ),
    GetPage(
      name: HomeView.id,
      page: () => const HomeView(),
    ),
    //tasks views
    GetPage(
      name: TaskDetailsView.id,
      page: () => const TaskDetailsView(),
    ),
    GetPage(
      name: AddTaskView.id,
      page: () => const AddTaskView(),
    ),
    GetPage(
      name: UpdateTaskView.id,
      page: () => const UpdateTaskView(),
    ),
    GetPage(
      name: TasksShiftView.id,
      page: () => TasksShiftView(),
    ),
  ];
}
