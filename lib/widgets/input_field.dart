import 'package:flutter/material.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
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
    this.suffix,
    this.prefixIcon,
    required this.lastname,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  final String? errorText;
  final String? hintText;
  final Function(String?) validation;
  final TextEditingController? controller;
  final TextInputType keywordType;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool lastname;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    // Set initial value if provided
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      style: AppFonts.poppinsRegular.copyWith(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keywordType,
      obscureText: obscureText,
      textInputAction: lastname ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.iconColor,
        errorText: errorText,
        fillColor: Colors.transparent.withOpacity(0.018),
        filled: true,
        contentPadding: EdgeInsets.only(
          bottom: deviceHeight * 0.018,
          top: deviceHeight * 0.015,
        ),
        prefix: lastname
            ? Padding(padding: EdgeInsets.only(left: deviceWidth * 0.04))
            : const Padding(padding: EdgeInsets.zero),
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
          borderSide: const BorderSide(
            width: 0.8,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.8, color: Colors.red),
          borderRadius: BorderRadius.circular(6),
        ),
        errorMaxLines: 3,
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
      validator: (value) => validation(value),
    );
  }
}
