import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

SnackBar buildErrorSnackBar(BuildContext context, dynamic error) {
  String errorMessage;

  if (error is TimeoutException) {
    errorMessage = 'Something went wrong. Please try again later.';
  } else if (error is SocketException) {
    errorMessage = 'Please check your internet connection.';
  } else {
    errorMessage = 'Something went wrong.';
  }

  return SnackBar(
      width: MediaQuery.of(context).size.width / 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      content: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align content vertically
        children: [
          Center(
              child: Image.asset(
            'assets/snackbar_icon.png',
            height: MediaQuery.of(context).size.height * 0.035,
          )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Flexible(
            child: Text(
              errorMessage,
              maxLines: 2,
              style: AppFonts.poppinsLightMediumsnackBar.copyWith(
                  color: AppColors.kWhiteColor,
                  fontSize: AppFonts.smallFontSize),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.kBlackColor);
}
