import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';

import '../../controllers/password_controller.dart';
import '../../widgets/input_field.dart';

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
  PasswordController controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          backgroundColor: AppColors.planeColor),
      backgroundColor: AppColors.planeColor,
      body: Center(
        child: GestureDetector(
          onTapCancel: () {},
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Form(
            key: _formKey2,
            child: ListView(physics: const ClampingScrollPhysics(), children: [
              SizedBox(
                height: deviceHeight * 0.06,
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          keywordType: TextInputType.name,
                          obscureText: false,
                          controller: firstname,
                          hintText: 'First Name',
                          errorText: null,
                          suffix: null,
                          lastname: false,
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
                          keywordType: TextInputType.name,
                          obscureText: false,
                          controller: lastname,
                          hintText: 'Last Name',
                          errorText: null,
                          suffix: null,
                          lastname: true,
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
                      prefixIcon: const Icon(Icons.local_phone_outlined),
                      errorText: null,
                      hintText: 'Phone',
                      keywordType: TextInputType.number,
                      lastname: false,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        } else if (value.length != 10 || value.length > 10) {
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
                        prefixIcon: const Icon(Icons.email_outlined),
                        errorText: null,
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
                        lastname: false,
                        suffix: null),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    GetBuilder<PasswordController>(
                      builder: (controller) {
                        return Column(
                          children: [
                            InputField(
                                prefixIcon: const Icon(Icons.lock_outlined),
                                errorText: null,
                                hintText: 'Password',
                                keywordType: TextInputType.visiblePassword,
                                lastname: false,
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
                              prefixIcon: const Icon(Icons.lock_outlined),
                              errorText: null,
                              hintText: 'Confirm Password',
                              keywordType: TextInputType.visiblePassword,
                              lastname: false,
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
                        );
                      },
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
                            // final isvalid = _formKey2.currentState!.validate();
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
                              Get.back();
                            },
                            child: Text('Login',
                                style: AppFonts.poppinsRegular
                                    .copyWith(color: AppColors.primaryColor)))
                      ],
                    )
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
