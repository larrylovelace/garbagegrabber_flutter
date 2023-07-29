import 'package:flutter/material.dart';


import 'package:hive/hive.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class QRprofile extends StatefulWidget {
  const QRprofile({super.key});

  @override
  State<QRprofile> createState() => _QRprofileState();
}

class _QRprofileState extends State<QRprofile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var box = Hive.box('homedata');
    var products = box.get('homedata');
    return products != null
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
                      data: products!.qrcodeno,
                      version: QrVersions.auto,
                      size: deviceWidth * 0.6,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    Text(
                      "${products!.firstname} ${products!.lastname}",
                      style: AppFonts.poppinsBold
                          .copyWith(fontSize: AppFonts.largeFontSize),
                    ),
                    Text(
                      products!.email,
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
