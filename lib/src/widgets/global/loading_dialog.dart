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
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                      strokeWidth: 3, color: AppColors.kPrimaryColor),
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
