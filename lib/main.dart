import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:garbage_grabber/controllers/routes.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
      ),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
