import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.headertext,
    required this.errortext,
  });

  final double deviceHeight;
  final double deviceWidth;
  final String headertext;
  final String errortext;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: deviceHeight * 0.18,
        child: Padding(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.05, right: deviceWidth * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.014,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(headertext,
                          style: AppFonts.poppinsMedium.copyWith(
                              color: AppColors.errorColor,
                              fontSize: AppFonts.errorDialogHead)),
                      SizedBox(
                        width: deviceWidth * 0.02,
                      ),
                      Icon(
                        Icons.error,
                        color: AppColors.errorColor,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(errortext,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.errorDialogBody)),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: deviceHeight * 0.04,
                    width: deviceWidth * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.errorColor),
                    child: MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'OK ',
                        style: AppFonts.poppinsLightMedium.copyWith(
                            color: AppColors.planeColor,
                            fontSize: AppFonts.mediumFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
