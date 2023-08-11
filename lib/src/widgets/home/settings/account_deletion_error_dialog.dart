import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../custom_button.dart';

class AccountDeletionErrorDialog extends StatelessWidget {
  const AccountDeletionErrorDialog({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.data,
  });

  final double deviceWidth;
  final double deviceHeight;
  final Map<String, dynamic> data;

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
        height: deviceHeight * 0.27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['error'],
                    maxLines: 2,
                    style: AppFonts.poppinsMedium.copyWith(
                        fontSize: AppFonts.mediumFontSize,
                        color: AppColors.errorColor)),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Text(
              data['message'],
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smallFontSize),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    text: 'OK',
                    textcolor: AppColors.planeColor,
                    buttoncolor: AppColors.pricecalcontainer,
                    oncallback: () {
                      Get.back();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
