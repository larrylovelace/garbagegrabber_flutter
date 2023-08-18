import 'package:flutter/material.dart';
import '../../../data/controllers/home/settings/settings_screen_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../global/custom_button.dart';

class AccountDeletionDialog extends StatelessWidget {
  const AccountDeletionDialog(
      {super.key,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.settingsScreenController,
      required this.headerText,
      required this.bodyText,
      required this.onPressed1,
      required this.onPressed2,
      this.warningitems = false});

  final double deviceWidth;
  final double deviceHeight;
  final SettingsScreenController settingsScreenController;
  final String headerText;
  final String bodyText;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final bool warningitems;

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
            Row(children: [
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
                    maxLines: 2,
                    style: AppFonts.poppinsMedium.copyWith(
                        fontSize: AppFonts.mediumFontSize,
                        color: AppColors.kErrorColor)),
              ),
            ]),
            SizedBox(
              height: deviceHeight * 0.01,
            ),
            Text(
              bodyText,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smallFontSize),
            ),
            warningitems
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: AppColors.kBlackColor,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text('Profile details',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: AppFonts.smallFontSize))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: AppColors.kBlackColor,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text('Address details',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: AppFonts.smallFontSize))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: AppColors.kBlackColor,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text('Appointments',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: AppFonts.smallFontSize))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: AppColors.kBlackColor,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(width: deviceWidth * 0.02),
                          Text('Payments',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: AppFonts.smallFontSize))
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
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
                    textcolor: AppColors.kBlackColor,
                    buttoncolor: AppColors.kWhiteColor,
                    oncallback: onPressed1),
                CustomButton(
                  deviceHeight: deviceHeight,
                  deviceWidth: deviceWidth,
                  text: 'Delete',
                  textcolor: AppColors.kWhiteColor,
                  buttoncolor: AppColors.kErrorColor,
                  oncallback: onPressed2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
