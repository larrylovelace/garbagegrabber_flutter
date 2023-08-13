import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../services/apihandler.dart';
import '../../../data/controllers/routes.dart';
import '../../../data/controllers/start/setup_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbars/error_handling.dart';
import '../../../widgets/start/input_field.dart';
import '../../../widgets/global/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  SetupScreenController controller = Get.put(SetupScreenController());
  Map sendingBody = {};

  Future<void> signup(sendigBody) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.customerSignUp;
      var response = await http.post(Uri.parse(uri), body: sendingBody);

      if (response.statusCode == 200) {
        Get.back();
        Get.toNamed(AppRoutes.otpscreen,
            arguments: {'email': email.text, 'password': password.text});
      } else if (response.statusCode == 400) {
        Map value = jsonDecode(response.body);
        Map extractedvalue = value['errors'];

        if (extractedvalue.containsKey('email')) {
          controller.errormailoccur(extractedvalue['email'][0]);
        }
        if (extractedvalue.containsKey("phone_number")) {
          controller.errorphoneoccur(extractedvalue['phone_number'][0]);
        }
        Get.back();
      }
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
      appBar: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 1,
          elevation: 0,
          backgroundColor: AppColors.planeColor),
      backgroundColor: AppColors.planeColor,
      body: Center(
        child: GestureDetector(
          onTapCancel: () {},
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: GetBuilder<SetupScreenController>(
            builder: (controller) {
              return Form(
                key: _formKey2,
                child:
                    ListView(physics: const ClampingScrollPhysics(), children: [
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: AppFonts.poppinsBold
                            .copyWith(fontSize: AppFonts.largeFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: deviceWidth * 0.05,
                      right: deviceWidth * 0.05,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: InputField(
                              readonly: false,
                              isPrefix: true,
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              keywordType: TextInputType.name,
                              obscureText: false,
                              controller: firstname,
                              hintText: 'First Name',
                              errorText: null,
                              suffix: null,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Required');
                                }

                                if (RegExp(r"\s").hasMatch(value)) {
                                  return 'Spaces are not allowed';
                                }
                                if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return 'Enter the correct name';
                                }
                              },
                            )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Expanded(
                                child: InputField(
                              readonly: false,
                              isPrefix: true,
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              keywordType: TextInputType.name,
                              obscureText: false,
                              controller: lastname,
                              hintText: 'Last Name',
                              errorText: null,
                              suffix: null,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Required');
                                }

                                if (RegExp(r"\s").hasMatch(value)) {
                                  return 'Spaces are not allowed';
                                }
                                if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return 'Enter the correct name';
                                }
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        InputField(
                          readonly: false,
                          isPrefix: true,
                          prefixIcon: const Icon(Icons.local_phone_outlined),
                          errorText: controller.phonenumerror
                              ? controller.errorhponevalue
                              : null,
                          hintText: 'Phone',
                          keywordType: TextInputType.number,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            } else if (value.length != 10 ||
                                value.length > 10) {
                              return 'The phone number must be 10 digits long.';
                            }
                          },
                          obscureText: false,
                          controller: phoneNum,
                          suffix: null,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        InputField(
                            readonly: false,
                            isPrefix: true,
                            prefixIcon: const Icon(Icons.email_outlined),
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
                            suffix: null),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Column(
                          children: [
                            InputField(
                                readonly: false,
                                isPrefix: true,
                                prefixIcon: const Icon(Icons.lock_outlined),
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
                                obscureText: controller.passwordObscuredsignup,
                                controller: password,
                                suffix: null),
                            SizedBox(
                              height: deviceHeight * 0.02,
                            ),
                            InputField(
                              readonly: false,
                              isPrefix: true,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              errorText: null,
                              hintText: 'Confirm Password',
                              keywordType: TextInputType.visiblePassword,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please re-enter your password';
                                } else if (RegExp(r"\s").hasMatch(value)) {
                                  return 'Spaces are not allowed';
                                } else if (value != password.text) {
                                  return ' Passwords donot match';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: controller.passwordObscuredsignup,
                              controller: confirmpassword,
                              suffix: IconButton(
                                splashRadius: 5,
                                onPressed: (() {
                                  controller.signupVisibility();
                                }),
                                icon: Icon(
                                    controller.passwordObscuredsignup
                                        ? Icons.visibility_off_sharp
                                        : Icons.visibility_sharp,
                                    color: AppColors.iconColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: deviceWidth * 0.05,
                      right: deviceWidth * 0.05,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: deviceHeight * 0.052,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primaryColor),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () async {
                                final isvalid =
                                    _formKey2.currentState!.validate();
                                if (isvalid) {
                                  FocusScope.of(context).unfocus();
                                  LoadingDialog.show(context);
                                  sendingBody = {
                                    "first_name": firstname.text,
                                    "last_name": lastname.text,
                                    "phone_number": "+1${phoneNum.text}",
                                    "email": email.text,
                                    "password": password.text,
                                    "confirm_password": password.text,
                                  };
                                  await signup(sendingBody);
                                }
                              },
                              child: Text('Sign up',
                                  style: AppFonts.poppinsMedium.copyWith(
                                      fontSize: AppFonts.mediumFontSize,
                                      color: AppColors.planeColor))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account ?",
                                style: AppFonts.poppinsRegular.copyWith()),
                            TextButton(
                                onPressed: () {
                                  Get.offNamed(AppRoutes.login);
                                },
                                child: Text('Login',
                                    style: AppFonts.poppinsRegular.copyWith(
                                        color: AppColors.primaryColor)))
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
