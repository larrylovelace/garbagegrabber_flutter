import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.errorText,
    required this.hintText,
    required this.keywordType,
    required this.validation,
    required this.obscureText,
    this.controller,
    required this.isPrefix,
    this.suffix,
    this.prefixIcon,
    required this.readonly,
  }) : super(key: key);

  final String? errorText;
  final String? hintText;
  final Function(String?) validation;
  final TextEditingController? controller;
  final TextInputType keywordType;
  final bool obscureText;
  final bool isPrefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    // Set initial value if provided
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      cursorColor: AppColors.secondaryColorBlack,
      cursorHeight: deviceHeight * 0.027,
      style: AppFonts.poppinsRegular.copyWith(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keywordType,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.iconColor,
        errorText: errorText,
        fillColor: AppColors.fillColor,
        filled: true,
        contentPadding: EdgeInsets.only(
          bottom: deviceHeight * 0.018,
          top: deviceHeight * 0.015,
        ),
        prefix: isPrefix
            ? const Padding(padding: EdgeInsets.zero)
            : Padding(padding: EdgeInsets.only(left: deviceWidth * 0.04)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.1,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: hintText,
        hintStyle: AppFonts.poppinsRegular.copyWith(
            fontSize: AppFonts.smallFontSize,
            color: AppColors.iconColor,
            letterSpacing: 0.5),
        suffixIcon: suffix,
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.8,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8, color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.8, color: Colors.red),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.8, color: Colors.red),
          borderRadius: BorderRadius.circular(6),
        ),
        errorMaxLines: 3,
        errorStyle: GoogleFonts.poppins(color: Colors.red),
      ),
      validator: (value) => validation(value),
    );
  }
}
