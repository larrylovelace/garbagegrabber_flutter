import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/controllers/home/settings/settings_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../custom_button.dart';
import '../../global/loading_dialog.dart';

class AccountDeletionDialog extends StatelessWidget {
  const AccountDeletionDialog({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.settingsScreenController,
    required this.headerText,
    required this.bodyText,
  });

  final double deviceWidth;
  final double deviceHeight;
  final SettingsScreenController settingsScreenController;
  final String headerText;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.only(
            left: deviceWidth * 0.05, right: deviceWidth * 0.05),
        decoration: BoxDecoration(
            color: AppColors.planeColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: deviceHeight * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(headerText,
                    maxLines: 2,
                    style: AppFonts.poppinsMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize)),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Text(
              bodyText,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smallFontSize),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    text: 'Cancel',
                    textcolor: AppColors.planeColor,
                    buttoncolor: AppColors.pricecalcontainer,
                    oncallback: () {
                      Get.back();
                    }),
                CustomButton(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    text: 'Delete',
                    textcolor: AppColors.planeColor,
                    buttoncolor: AppColors.errorColor,
                    oncallback: () {
                      Get.back();
                      LoadingDialog.show(context);
                      settingsScreenController.deleteAccount(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
