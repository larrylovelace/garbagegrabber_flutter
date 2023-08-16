import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_grabber/src/data/controllers/routes.dart';
import 'package:garbage_grabber/src/ui/screens/home/screenhandler.dart';
import 'package:garbage_grabber/src/widgets/global/custom_button.dart';
import 'package:garbage_grabber/src/widgets/global/error_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../services/apihandler.dart';
import '../../../data/controllers/start/setup_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbars/error_handling.dart';
import '../../../widgets/snackbars/error_snackbar.dart';
import '../../../widgets/start/input_field.dart';
import '../../../widgets/global/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = const FlutterSecureStorage();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  SetupScreenController controller = Get.put(SetupScreenController());
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  Map sendingBody = {};
  final MainScreenController mainScreenController =
      Get.find<MainScreenController>();
  Future<void> login(BuildContext context, sendingBody) async {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    try {
      String uri = APIConstants.baseURI + APIConstants.customerLogin;
      var response = await http.post(Uri.parse(uri), body: sendingBody);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        await storage.write(
            key: 'stripe_id', value: data['payment_id'].toString());
        await storage.write(
            key: 'refreshtoken', value: data['token']['refresh'].toString());
        await storage.write(
            key: 'accesstoken', value: data['token']['access'].toString());

        Get.back();
        mainScreenController.resetController();
        Get.offAllNamed(AppRoutes.screenhandler);
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          'Login successfully',
        );
      } else if (response.statusCode == 400) {
        Map value = jsonDecode(response.body);

        if (value.containsKey('email')) {
          controller.errormailoccur(value['email'][0]);
        } else if (value.containsKey("non_field_errors")) {
          controller.errormailoccur(value['non_field_errors'][0]);
        } else if (value.containsKey("password")) {
// ignore: use_build_context_synchronously
          CustomSnackBar.show(
            context,
            value['password'][0],
          );
        }

        Get.back();
      } else if (response.statusCode == 403) {
        controller.isLoadingindicator();
        Get.back();
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) => OtpDialog(
                  email: email,
                  password: password,
                ));
      } else if (response.statusCode == 422) {
        Get.back();
        // ignore: use_build_context_synchronously
        Get.dialog(ErrorDialog(
          setupScreenDialog: true,
          text: 'Cancel',
          deviceWidth: deviceWidth,
          deviceHeight: deviceHeight,
          headerText: 'Profile Details are not filled',
          bodyText: 'Continue to fill your details',
          onPressed: () {
            Get.back();
            Get.toNamed(AppRoutes.formfill,
                arguments: {'email': email.text, 'password': password.text});
          },
        ));
      } else {}
    } catch (e) {
      Get.back();
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: AppColors.kBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: GestureDetector(
          onTapCancel: () {},
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: GetBuilder<SetupScreenController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.only(
                  left: deviceWidth * 0.08,
                  right: deviceWidth * 0.08,
                ),
                child: Form(
                  key: _formKey1,
                  child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SvgPicture.asset(
                          'assets/login.svg',
                          height: deviceHeight * 0.38,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Login',
                                style: AppFonts.poppinsBold.copyWith(
                                    fontSize: AppFonts.largeFontSize)),
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Column(
                          children: [
                            InputField(
                              readonly: false,
                              isPrefix: true,
                              prefixIcon: Icons.email_outlined,
                              errorText: controller.errormail
                                  ? controller.errormailvalue
                                  : null,
                              hintText: 'Email',
                              keywordType: TextInputType.emailAddress,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email required ';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Invalid format';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: false,
                              controller: email,
                              suffix: null,
                            ),
                            SizedBox(
                              height: deviceHeight * 0.02,
                            ),
                            InputField(
                              readonly: false,
                              isPrefix: true,
                              prefixIcon: Icons.lock_outlined,
                              errorText: null,
                              hintText: 'Password',
                              keywordType: TextInputType.visiblePassword,
                              validation: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 8) {
                                  return 'Your password must be at least 8 characters';
                                } else if (RegExp(r"\s").hasMatch(value)) {
                                  return 'Spaces are not allowed';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: controller.passwordObscuredlogin,
                              controller: password,
                              suffix: IconButton(
                                splashRadius: 5,
                                onPressed: (() {
                                  controller.loginVisibility();
                                }),
                                icon: Icon(
                                  controller.passwordObscuredlogin
                                      ? Icons.visibility_off_sharp
                                      : Icons.visibility_sharp,
                                  color: AppColors.iconColor,
                                  size: AppFonts.largeFontSize,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.kPrimaryColor),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () async {
                                final isvalid =
                                    _formKey1.currentState!.validate();
                                if (isvalid) {
                                  FocusScope.of(context).unfocus();
                                  LoadingDialog.show(context);

                                  sendingBody = {
                                    "email": email.text,
                                    "password": password.text
                                  };
                                  await login(context, sendingBody);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Login',
                                      style: AppFonts.poppinsMedium.copyWith(
                                          fontSize: AppFonts.mediumFontSize,
                                          color: AppColors.kWhiteColor)),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ?",
                                style: AppFonts.poppinsRegular.copyWith()),
                            TextButton(
                                onPressed: () {
                                  // Get.delete();
                                  Get.offNamed(AppRoutes.register);
                                },
                                child: Text(
                                  'Sign up',
                                  style: AppFonts.poppinsRegular.copyWith(
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ))
                          ],
                        ),
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OtpDialog extends StatelessWidget {
  OtpDialog({
    super.key,
    required this.email,
    required this.password,
  });

  final TextEditingController email;
  final TextEditingController password;

  SetupScreenController controller = Get.put(SetupScreenController());
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: AppColors.kBackgroundColor,
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.05, right: deviceWidth * 0.05),
          height: deviceHeight * 0.22,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Please verify your email",
                    style: AppFonts.poppinsLightMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize)),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Column(
              children: [
                Row(
                  children: [
                    Text('Send the verification code to',
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.smallFontSize)),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.005),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: deviceWidth * 0.04),
                      width: deviceWidth * 0.55,
                      decoration: BoxDecoration(
                          color: AppColors.iconColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(email.text,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: AppFonts.snackBarfontlarge)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.042,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth / 1.1,
                        text: 'Send',
                        textcolor: AppColors.kWhiteColor,
                        buttoncolor: AppColors.kPrimaryColor,
                        oncallback: () async {
                          LoadingDialog.show(context);
                          try {
                            String uri = APIConstants.baseURI +
                                APIConstants.customerEmailVerification;
                            var response =
                                await http.post(Uri.parse(uri), body: {
                              "email": email.text,
                            });
                            if (response.statusCode == 200) {
                              Get.back();
                              Get.back();
                              Get.toNamed(AppRoutes.otpscreen, arguments: {
                                'email': email.text,
                                'password': password.text,
                              });
                            } else {
                              Get.back();
                            }
                          } catch (e) {
                            Get.back();
                            final snackBar = buildErrorSnackBar(context, e);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }),
                    CustomButton(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth / 1.1,
                        text: 'Cancel',
                        textcolor: AppColors.kWhiteColor,
                        buttoncolor: AppColors.kCancelButtonColor,
                        oncallback: () {
                          Get.back();
                        })
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

// ignore: must_be_immutable
