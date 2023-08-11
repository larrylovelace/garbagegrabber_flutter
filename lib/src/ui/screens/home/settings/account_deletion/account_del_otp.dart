import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:http/http.dart' as http;

import '../../../../../data/controllers/home/settings/settings_controller.dart';
import '../../../../../services/apihandler.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../widgets/snackbars/error_handling.dart';
import '../../../../../widgets/snackbars/error_snackbar.dart';

Timer? resendTimer;

class AccountDeletionOTP extends StatefulWidget {
  const AccountDeletionOTP({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountDeletionOTP> createState() => _AccountDeletionOTPState();
}

class _AccountDeletionOTPState extends State<AccountDeletionOTP> {
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final SettingsScreenController settingsScreenController =
      Get.put(SettingsScreenController());
  final storage = const FlutterSecureStorage();
  String email = Get.arguments['email'];

  int countdown = 60;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    resendTimer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    resendTimer?.cancel(); // Cancel any existing timer

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          // Countdown reached 0, stop the timer and show the resend text
          timer.cancel();
          settingsScreenController.showResendText.value = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.planeColor,
      appBar: AppBar(
        leading: Ink(
          child: IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
            splashColor: Colors.transparent, // Set splashColor to transparent
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: AppColors.planeColor,
      ),
      body: Center(
          child: Obx(
        () => GestureDetector(
          onTapCancel: () {},
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Form(
            key: _formKey3,
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter the verification code',
                    style: AppFonts.poppinsMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize),
                  )
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OTP was sent to $email',
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppinsRegular.copyWith())
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                child: SizedBox(
                  child: PinCodeTextField(
                    animationType: AnimationType.scale,
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    cursorWidth: 0.9,
                    cursorHeight: 17,
                    cursorColor: Colors.black,
                    enableActiveFill: true,
                    textStyle: AppFonts.poppinsMedium.copyWith(),
                    onChanged: (value) {
                      settingsScreenController.enteredCode = value;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldWidth: deviceWidth * 0.13,
                      fieldHeight: deviceWidth * 0.13,
                      borderRadius: BorderRadius.circular(6),
                      borderWidth: 0.5,
                      activeColor: settingsScreenController.isotpInvalid.value
                          ? AppColors.errorColor
                          : AppColors.primaryColor,
                      activeFillColor: Colors.transparent.withOpacity(0.018),
                      inactiveFillColor: Colors.transparent.withOpacity(0.018),
                      selectedFillColor: Colors.transparent.withOpacity(0.018),
                      selectedColor: Colors.transparent.withOpacity(0.08),
                      inactiveColor: Colors.transparent.withOpacity(0.08),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Did not get the code? ",
                            style: AppFonts.poppinsRegular.copyWith()),
                        if (settingsScreenController.showResendText.value)
                          TextButton(
                            onPressed: () async {
                              try {
                                String uri = APIConstants.baseURI +
                                    APIConstants.customerEmailVerification;
                                var response =
                                    await http.post(Uri.parse(uri), body: {
                                  "email":
                                      email, // Use the email variable directly
                                });
                                if (response.statusCode == 200) {
                                  // Start the resend timer and hide the resend text
                                  settingsScreenController
                                      .showResendText.value = false;
                                  countdown = 59;
                                  startResendTimer();
                                  // ignore: use_build_context_synchronously
                                  CustomSnackBar.show(
                                    context,
                                    'Success',
                                    'OTP code sent successfully',
                                    AppColors.primaryColor,
                                    Icons.check, // Custom icon
                                    AppColors.primaryColor,
                                  );
                                }
                              } catch (e) {
                                final snackBar = buildErrorSnackBar(context, e);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Resend code',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        if (!settingsScreenController.showResendText.value)
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                  'Resend in ${countdown.toString().padLeft(2, '0')} sec',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.poppinsRegular.copyWith(
                                      color: AppColors.primaryColor))),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    Container(
                      height: deviceHeight * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primaryColor),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          onPressed: () async {
                            if (settingsScreenController.enteredCode.isEmpty ||
                                settingsScreenController.enteredCode.length <
                                    6) {
                              settingsScreenController.isLoading.value = false;

                              CustomSnackBar.show(
                                  context,
                                  'Error',
                                  'Enter the OTP',
                                  AppColors
                                      .errorColor, // Custom background color
                                  Icons.error_rounded, // Custom icon
                                  AppColors.errorColor // Custom icon color
                                  );
                            } else {
                              settingsScreenController.verifyCode(context);
                            }
                          },
                          child: settingsScreenController.isLoading.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: deviceWidth * 0.062,
                                      height: deviceWidth * 0.062,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.7,
                                          color: AppColors.planeColor),
                                    ),
                                  ],
                                )
                              : Text('Verify',
                                  style: AppFonts.poppinsMedium.copyWith(
                                      fontSize: AppFonts.mediumFontSize,
                                      color: AppColors.planeColor))),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
