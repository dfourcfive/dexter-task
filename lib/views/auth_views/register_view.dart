import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation_view.dart';

class RegisterView extends StatelessWidget {
  static const id = '/register-view';

  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      providers: [EmailAuthProvider()],
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.offNamed(NavigationView.id);
        }),
      ],
    );
  }
}
