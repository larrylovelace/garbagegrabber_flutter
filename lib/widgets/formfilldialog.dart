import 'package:flutter/material.dart';
import 'package:garbage_grabber/controllers/routes.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';

// ignore: must_be_immutable
class FormFillDialog extends StatelessWidget {
  const FormFillDialog({
    super.key,
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      elevation: 0,
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      title: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight * 0.2,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Profile details are not filled",
                    style: AppFonts.poppinsLightMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize)),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Column(
              children: [
                Row(
                  children: [
                    Text('Continue to fill your details',
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.smallFontSize)),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.005),
                SizedBox(
                  height: deviceHeight * 0.042,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.24,
                      child: Container(
                        height: deviceHeight * 0.044,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primaryColor),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          onPressed: () async {
                            Get.back();
                            Get.toNamed(AppRoutes.formfill, arguments: {
                              'email': email,
                              'password': password
                            });
                          },
                          child: Text('Continue',
                              style: AppFonts.poppinsLightMedium.copyWith(
                                  color: AppColors.planeColor,
                                  fontSize: AppFonts.snackBarfontsmall)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.03,
                    ),
                    SizedBox(
                      width: deviceWidth * 0.24,
                      child: Container(
                        height: deviceHeight * 0.044,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.errorColor),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel',
                              style: AppFonts.poppinsLightMedium.copyWith(
                                  color: AppColors.planeColor,
                                  fontSize: AppFonts.snackBarfontsmall)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
