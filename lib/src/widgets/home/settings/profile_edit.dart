import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class ProfileEditField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const ProfileEditField({
    required this.controller,
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: deviceWidth * 0.05),
          labelText: labelText,
          labelStyle: AppFonts.poppinsRegular
              .copyWith(letterSpacing: 0.2, fontSize: AppFonts.smallFontSize),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(12)))),
    );
  }
}
