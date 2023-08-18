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
  final textWidth = calculateTextWidth(
      errorMessage,
      AppFonts.poppinsLightMediumsnackBar
          .copyWith(fontSize: AppFonts.smallFontSize));
  final snackBarWidth = textWidth +
      32; // Add some padding to the text width for better visual appearance

  return SnackBar(
      width: snackBarWidth,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

double calculateTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 2,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.width;
}
