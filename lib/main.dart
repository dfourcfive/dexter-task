import 'package:dexter_task/controllers/auth_controller.dart';
import 'package:dexter_task/controllers/navigation_controller.dart';
import 'package:dexter_task/controllers/shifts_controller.dart';
import 'package:dexter_task/controllers/tasks_controller.dart';
import 'package:dexter_task/controllers/user_controller.dart';
import 'package:dexter_task/localization.dart';
import 'package:dexter_task/repos/nurse_repo.dart';
import 'package:dexter_task/routes.dart';
import 'package:dexter_task/spalsh_view.dart';
import 'package:dexter_task/theme.dart';
import 'package:dexter_task/views/auth_views/auth_view.dart';
import 'package:dexter_task/views/navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data_generation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Translations local = await LocaleStrings().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await generateShifts();
  initControllers();
  NurseRepo().listenAndAssignNurse();
  runApp(App(
    local: local,
  ));
}

class App extends StatelessWidget {
  Translations local;
  App({Key? key, required this.local}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //use design size from figma/adobe ... , it depends on the device's dimensions that was used
      designSize: const Size(375, 803),
      //
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: local,
        locale: LocaleStrings.defaultLocale,
        fallbackLocale: LocaleStrings.fallBackLocal,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        getPages: AppRoutes.routes,
        //first route use figma
        initialRoute: SplashView.id,
        themeMode: ThemeMode.light,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}

void initControllers() {
  Get.put<UserController>(UserController());
  Get.put<NavigationController>(NavigationController());
  Get.put<TasksController>(TasksController());
  Get.put<ShiftsController>(ShiftsController());
  final authController = Get.put<AuthController>(AuthController());
  authController.init();
}
