import 'package:dexter_task/models/nurse_model.dart';
import 'package:get/get.dart';

import '../repos/nurse_repo.dart';

//this controller should focus on users activities , profile data , settings ...etc
class UserController extends GetxController {
  Rx<NurseModel?> currentUser = (null as NurseModel?).obs;

  Future<void> getCurrentUser() async {
    currentUser.value = await NurseRepo().getCurrentUser();
  }
}
