import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,
    String messageDescription,
  ) {
    final snackBar = SnackBar(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        width: MediaQuery.of(context).size.width / 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                messageDescription,
                maxLines: 2,
                style: AppFonts.poppinsLightMediumsnackBar.copyWith(
                    color: AppColors.kWhiteColor,
                    fontSize: AppFonts.smallFontSize),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.kBlackColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
