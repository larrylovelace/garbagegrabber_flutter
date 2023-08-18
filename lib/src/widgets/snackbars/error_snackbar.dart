import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,
    String messageDescription,
  ) {
    final textWidth = calculateTextWidth(
        messageDescription,
        AppFonts.poppinsLightMediumsnackBar
            .copyWith(fontSize: AppFonts.smallFontSize));
    final snackBarWidth = textWidth +
        32; // Add some padding to the text width for better visual appearance

    final snackBar = SnackBar(
      width: snackBarWidth, // Set the width dynamically
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              messageDescription,
              maxLines: 2,
              style: AppFonts.poppinsLightMediumsnackBar.copyWith(
                color: AppColors.kWhiteColor,
                fontSize: AppFonts.smallFontSize,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.kBlackColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width;
  }
}
