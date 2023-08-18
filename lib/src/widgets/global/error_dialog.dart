import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'custom_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.headerText,
    required this.bodyText,
    this.deleteAccountDialog = false,
    this.setupScreenDialog = false,
    this.text = 'OK',
    this.buttontext = 'Continue',
    this.onPressed,
  });

  final double deviceWidth;
  final double deviceHeight;
  final String headerText;
  final String bodyText;
  final bool deleteAccountDialog;
  final bool setupScreenDialog;
  final String text;
  final String buttontext;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.01),
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outlined,
                  color: AppColors.kErrorColor,
                  size: AppFonts.largeFontSize,
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Expanded(
                  child: Text(headerText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppinsMedium.copyWith(
                          fontSize: AppFonts.mediumFontSize,
                          color: AppColors.kErrorColor)),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.005,
            ),
            Column(
              children: [
                Text(
                  bodyText,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: AppFonts.poppinsRegular
                      .copyWith(fontSize: AppFonts.smallFontSize),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: setupScreenDialog
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                setupScreenDialog
                    ? CustomButton(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth / 1.1,
                        text: buttontext,
                        textcolor: AppColors.kWhiteColor,
                        buttoncolor: AppColors.kPrimaryColor,
                        oncallback: onPressed!)
                    : const SizedBox(),
                CustomButton(
                    deviceHeight: deviceHeight,
                    deviceWidth: setupScreenDialog
                        ? deviceWidth / 1.1
                        : deviceWidth / 1.8,
                    text: text,
                    textcolor: AppColors.kWhiteColor,
                    buttoncolor: AppColors.kCancelButtonColor,
                    oncallback: () {
                      Get.back();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
