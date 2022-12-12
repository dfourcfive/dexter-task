import 'package:dexter_task/views/home_views/home_view.dart';
import 'package:dexter_task/views/home_views/profile_view.dart';
import 'package:dexter_task/views/home_views/shifts_view.dart';
import 'package:get/get.dart';

import '../views/home_views/tasks_view.dart';

class NavigationController extends GetxController {
  List children = [HomeView(), TasksView(), ShiftsView(), ProfileView()];
  Rx<int> currentIndex = 0.obs;
}
