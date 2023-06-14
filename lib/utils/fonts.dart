import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final TextStyle poppinsRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
  );

  static final TextStyle poppinsMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle poppinsBold = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
  );

  static const double smallFontSize = 14.0;
  static const double mediumFontSize = 18.0;
  static const double largeFontSize = 24.0;
}
