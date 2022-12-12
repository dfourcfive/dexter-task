import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_views/auth_view.dart';

class ProfileView extends StatelessWidget {
  static const id = '/profile-view';

  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      providers: [EmailAuthProvider()],
      actions: [
        SignedOutAction((context) {
          Get.offAllNamed(AuthView.id);
        }),
      ],
    );
  }
}
