import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:garbage_grabber/src/data/controllers/routes.dart';
import 'package:garbage_grabber/src/models/products.dart';


import 'package:garbage_grabber/src/utils/colors.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'src/ui/screens/home/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainScreenController());
  await dotenv.load();
  await Hive.initFlutter();
  // Initialize Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Hive adapters
  Hive.registerAdapter(ProductsAdapter());
  Hive.registerAdapter(ProductDataAdapter());
  // Open Hive box
  await Hive.openBox('homedata');

  // Print the values inside the box

  Stripe.publishableKey = dotenv.env['publishablekey']!;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.primaryColor,
        systemNavigationBarColor: AppColors.planeColor // transparent status bar
        ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
