import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';

Timer? resendTimer;

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  var enteredCode;
  bool isLoading = false;
  bool isotpInvalid = false;

  var email;
  int countdown = 60;
  bool showResendText = true;

  Future<void> verifyCode() async {
    // if (enteredCode.length == 6) {
    //   FocusScope.of(context).unfocus();
    //   setState(() {
    //     isLoading = true;
    //   });
    //   try {
    //     String uri = APIConstants.baseURI + APIConstants.workerOtpValidate;
    //     var response =
    //         await http.post(Uri.parse(uri), body: {"otp": enteredCode});

    //     if (response.statusCode == 200) {
    //       var data = jsonDecode(response.body);

    //       await storage.write(
    //           key: 'refreshtoken', value: data['token']['refresh'].toString());
    //       await storage.write(
    //           key: 'accesstoken', value: data['token']['access'].toString());

    //       setState(() {
    //         isLoading = false;
    //         CustomSnackBar.show(
    //           context,
    //           'Success',
    //           'Login Successfully',
    //           const Color.fromARGB(255, 15, 191, 98), // Custom background color
    //           Icons.check, // Custom icon
    //           const Color.fromARGB(255, 15, 191, 98), // Custom icon color
    //         );
    //         Get.offAllNamed(AppRoutes.mainscreenhandler);
    //       });
    //     }

    //     if (response.statusCode == 400) {
    //       var errormsg = jsonDecode(response.body) as Map;

    //       setState(() {
    //         isotpInvalid = true;
    //         isLoading = false;
    //         CustomSnackBar.show(
    //           context,
    //           'Error',
    //           errormsg['error'],
    //           Colors.red, // Custom background color
    //           Icons.error_rounded, // Custom icon
    //           Colors.red, // Custom icon color
    //         );
    //       });
    //       Future.delayed(const Duration(seconds: 5), () {
    //         if (mounted) {
    //           setState(() {
    //             isotpInvalid = false;
    //           });
    //         }
    //       });
    //     }
    //   } catch (e) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     final snackBar = buildErrorSnackBar(context, e);
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     print(e);
    //   }
    //   // Trigger verification process here
    // }
  }

  @override
  void initState() {
    super.initState();
    email = 'test';
    // email = Get.arguments['email'];

    // Use the email address argument as needed
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
          showResendText = true;
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
        child: GestureDetector(
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
                      enteredCode = value;
                      verifyCode();
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldWidth: deviceWidth * 0.13,
                      fieldHeight: deviceWidth * 0.13,
                      borderRadius: BorderRadius.circular(6),
                      borderWidth: 0.5,
                      activeColor: isotpInvalid
                          ? Colors.red
                          : const Color.fromARGB(255, 15, 191, 98),
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
                        if (showResendText)
                          TextButton(
                            onPressed: () async {
                              // try {
                              //   String uri = APIConstants.baseURI +
                              //       APIConstants.workerEmailVerification;
                              //   var response =
                              //       await http.post(Uri.parse(uri), body: {
                              //     "email":
                              //         email, // Use the email variable directly
                              //   });
                              //   if (response.statusCode == 200) {
                              //     setState(() {
                              //       // Start the resend timer and hide the resend text
                              //       showResendText = false;
                              //       countdown = 59;
                              //       startResendTimer();
                              //       CustomSnackBar.show(
                              //         context,
                              //         'Success',
                              //         'OTP code sent successfully',
                              //         const Color.fromARGB(255, 15, 191,
                              //             98), // Custom background color
                              //         Icons.check, // Custom icon
                              //         const Color.fromARGB(255, 15, 191,
                              //             98), // Custom icon color
                              //       );
                              //     });
                              //   }
                              // } catch (e) {
                              //   final snackBar = buildErrorSnackBar(context, e);
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(snackBar);
                              //   print(e);
                              // }
                            },
                            child: Text(
                              'Resend code',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        if (!showResendText)
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
                            // if (enteredCode == null ||
                            //     enteredCode.isEmpty ||
                            //     enteredCode.length < 6) {
                            //   setState(() {
                            //     isLoading = false;
                            //     CustomSnackBar.show(
                            //       context,
                            //       'Error',
                            //       'Enter the OTP',
                            //       Colors.red, // Custom background color
                            //       Icons.error_rounded, // Custom icon
                            //       Colors.red, // Custom icon color
                            //     );
                            //   });
                            // } else {
                            //   verifyCode();
                            // }
                          },
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: deviceWidth * 0.062,
                                      height: deviceWidth * 0.062,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 1.7,
                                        color: Colors.white,
                                      ),
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
      ),
    );
  }
}
