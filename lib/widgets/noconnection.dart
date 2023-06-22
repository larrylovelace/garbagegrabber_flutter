import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../controllers/routes.dart';

class Noconnection extends StatefulWidget {
  const Noconnection({super.key});

  @override
  State<Noconnection> createState() => _NoconnectionState();
}

class _NoconnectionState extends State<Noconnection> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  void checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Internet connection restored, proceed with the app startup
      Get.offAllNamed(AppRoutes.splash);
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening for connectivity changes
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        // Internet connection restored, resume building the app
        Get.offAllNamed(AppRoutes.splash); // Close the dialog
        // Perform any necessary actions to resume the app flow
        // For example, you can navigate to a specific screen or reload data
        // ...
      }
    });
  }

  @override
  void dispose() {
    // Cancel the connectivity subscription when the widget is disposed
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      elevation: 0,
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      title: SingleChildScrollView(
        child: Column(children: [
          Icon(
            Icons.error,
            color: AppColors.errorColor,
            size: 32,
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Error', style: AppFonts.poppinsBold.copyWith()),
          SizedBox(height: deviceHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No internet connection",
                  style: AppFonts.poppinsMedium
                      .copyWith(fontSize: AppFonts.smallFontSize)),
            ],
          ),
          SizedBox(height: deviceHeight * 0.01),
          Column(
            children: [
              Text('Please check your internet',
                  style: AppFonts.poppinsRegular
                      .copyWith(fontSize: AppFonts.smallFontSize)),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: deviceWidth * 0.24,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  onPressed: () {
                    checkConnectivity();
                  },
                  child: Text('Recheck',
                      style: AppFonts.poppinsRegular.copyWith()),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.errorColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child:
                      Text('Close', style: AppFonts.poppinsRegular.copyWith()),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
