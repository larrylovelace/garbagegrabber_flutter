import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:garbage_grabber/utils/colors.dart';

import '../utils/fonts.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    Key? key,
    required currentSelectedValue,
    required this.selectingCategory,
    this.valueCategory,
    required this.heightofCategory,
    required this.onSelecting(neWvalue),
    required this.formvalidation(value),
  }) : super(key: key);

  final List<String> selectingCategory;
  final String? valueCategory;
  final double? heightofCategory;
  final Function(String?) onSelecting;
  final Function(String?) formvalidation;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return FormField<String>(builder: (FormFieldState<String> state) {
      return DropdownButtonFormField2(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: ((value) => formvalidation(value)),
        decoration: InputDecoration(
          fillColor: AppColors.fillColor,
          filled: true,
          contentPadding: EdgeInsets.only(
            bottom: deviceHeight * 0.018,
            top: deviceHeight * 0.015,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.1,
              color: Color.fromRGBO(0, 0, 0, 0.15),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: '    Select your apartment',
          hintStyle: AppFonts.poppinsRegular.copyWith(
              fontSize: AppFonts.smallFontSize,
              color: AppColors.iconColor,
              letterSpacing: 0.5),
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
            borderSide: BorderSide(width: 0.8, color: AppColors.errorColor),
            borderRadius: BorderRadius.circular(6),
          ),
          errorStyle: AppFonts.poppinsRegular.copyWith(
              fontSize: AppFonts.smallFontSize,
              color: AppColors.errorColor,
              letterSpacing: 0.5),
        ),
        onChanged: ((value) => onSelecting(value)),
        items: [
          ...selectingCategory.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smallFontSize),
              ),
            );
          }).toList(),
        ],
        dropdownStyleData: DropdownStyleData(
          elevation: 1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.secondaryColor),
          maxHeight: heightofCategory,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(6),
            thickness: MaterialStateProperty.all<double>(2),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.04, right: deviceWidth * 0.04),
        ),
      );
    });
  }
}
