import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';
class CustomSnackBar {
  static void show(
    BuildContext context,
    String message,
    String messageDescription,
    Color backgroundColor,
    IconData iconData,
    Color iconColor,
  ) {
    final snackBar = SnackBar(
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
                  iconData,
                  color: iconColor,
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
                    child: Text(message,
                        style: AppFonts.poppinsMedium.copyWith(
                            color: AppColors.planeColor,
                            fontSize: AppFonts.snackBarfontlarge)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.007,
                  ),
                  Flexible(
                    child: Text(
                      messageDescription,
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
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
