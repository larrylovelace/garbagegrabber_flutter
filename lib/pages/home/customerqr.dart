import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';

import 'package:http/http.dart ' as http;

import '../../controllers/apihandler.dart';
import '../../controllers/token_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/customers.dart';
import '../../widgets/error_handling.dart';

class QRprofile extends StatefulWidget {
  const QRprofile({super.key});

  @override
  State<QRprofile> createState() => _QRprofileState();
}

class _QRprofileState extends State<QRprofile> {
  UserData? userData; // Declare userData in the state
  Future<void> customerprofile() async {
    const storage = FlutterSecureStorage();
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.customerprofile;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          userData = UserData.fromJson(data);
          setState(() {});
        }
      }
    } catch (e) {
      Get.back();
      // ignore: use_build_context_synchronously
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    customerprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return userData != null
        ? SizedBox(
            height: deviceHeight * 0.55,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Text(
                      'My QR Code',
                      style: AppFonts.poppinsBold.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: AppFonts.largeFontSize),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    Text(
                      'Show your QR code to verify pickups',
                      style: AppFonts.poppinsRegular.copyWith(),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    QrImageView(
                      data: userData!.qrCodeIdentifier,
                      version: QrVersions.auto,
                      size: deviceWidth * 0.6,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    Text(
                      "${userData!.firstName} ${userData!.lastName}",
                      style: AppFonts.poppinsBold
                          .copyWith(fontSize: AppFonts.largeFontSize),
                    ),
                    Text(
                      userData!.email,
                      style: AppFonts.poppinsRegular.copyWith(),
                    ),
                  ],
                ),
              ),
            ))
        : SizedBox(
            height: deviceHeight * 0.2,
            child: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
          );
  }
}
