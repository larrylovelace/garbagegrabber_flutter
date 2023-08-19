import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static double deviceWidth = 0.0;
  static double deviceHeight = 0.0;

  static void init(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
  }

  static double _scaleFactor() {
    double scaleFactor;

    if (deviceWidth > 1000 || deviceHeight > 1000) {
      scaleFactor = 2.5;
    } else if (deviceWidth > 800 || deviceHeight > 800) {
      scaleFactor = 1.0;
    } else {
      scaleFactor = 0.8;
    }

    return scaleFactor;
  }

  static double scaledFontSize(double baseFontSize) {
    return baseFontSize * _scaleFactor();
  }

  // Define your font size constants
  static double smallFontSize = scaledFontSize(14.0);
  static double mediumFontSize = scaledFontSize(18.0);
  static double largeFontSize = scaledFontSize(24.0);
  static double snackBarfontlarge = scaledFontSize(13.0);
  static double snackBarfontsmall = scaledFontSize(12.0);
  static double errorDialogHead = scaledFontSize(21.0);
  static double errorDialogBody = scaledFontSize(15.0);
  static double smalltext = scaledFontSize(13.0);
  static double mediumtext = scaledFontSize(16.0);
  static double minimalText = scaledFontSize(12);
  static double navBarSize = scaledFontSize(12);
  static double innerboxTextSize = scaledFontSize(9);

  static final TextStyle poppinsRegular = GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: scaledFontSize(16.0),
      letterSpacing: 0.1,
      color: AppColors.kBlackColor);

  static final TextStyle poppinsLightMediumsnackBar = GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: scaledFontSize(14.0),
      letterSpacing: 0.1,
      color: AppColors.kBlackColor);

  static final TextStyle poppinsLightMedium = GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: scaledFontSize(16.0),
      letterSpacing: 0.1,
      color: AppColors.kBlackColor);

  static final TextStyle poppinsMedium = GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: scaledFontSize(18.0),
      letterSpacing: 0.1,
      color: AppColors.kBlackColor);

  static final TextStyle poppinsBold = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: scaledFontSize(20.0),
      letterSpacing: 0.1,
      color: AppColors.kBlackColor);

  // Define other text styles similarly

  // ... Rest of your code
}
