import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

SnackBar buildErrorSnackBar(BuildContext context, dynamic error) {
  String errorMessage;
  IconData errorIcon;

  if (error is TimeoutException) {
    errorMessage = 'Something went wrong. Please try again later.';
    errorIcon = Icons.error_rounded;
  } else if (error is SocketException) {
    errorMessage = 'Please check your internet connection.';
    errorIcon = Icons.wifi_off_rounded;
  } else {
    errorMessage = 'Something went wrong.';
    errorIcon = Icons.error_rounded;
  }

  return SnackBar(
    elevation: 0,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    content: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width * 0.06,
      height: MediaQuery.of(context).size.height * 0.048,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.06,
            height: MediaQuery.of(context).size.width * 0.06,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                errorIcon,
                color: Colors.red,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Error',
                    style: AppFonts.poppinsMedium.copyWith(
                        color: AppColors.planeColor,
                        fontSize: AppFonts.snackBarfontlarge),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.007,
                ),
                Flexible(
                  child: Text(
                    errorMessage,
                    style: AppFonts.poppinsLightMediumsnackBar.copyWith(
                        color: AppColors.planeColor,
                        fontSize: AppFonts.snackBarfontsmall),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.red,
  );
}
