import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: AppColors.kBackgroundColor,
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: deviceWidth * 0.07,
                  height: deviceWidth * 0.07,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.kPrimaryColor),
                ),
                SizedBox(width: deviceWidth * 0.05),
                Text(
                  'Loading...',
                  style: AppFonts.poppinsMedium.copyWith(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
