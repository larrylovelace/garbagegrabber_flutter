import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:google_fonts/google_fonts.dart';
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
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      elevation: 0,
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      title: SingleChildScrollView(
        child: Column(children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 32,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Error',
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No internet connection",
                style: GoogleFonts.poppins(
                    letterSpacing: 0.3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Column(
            children: [
              Text(
                'Please check your internet',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 15, 191, 98)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: () {
                    checkConnectivity();
                  },
                  child: Text(
                    'Recheck',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.24,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    'Close',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}