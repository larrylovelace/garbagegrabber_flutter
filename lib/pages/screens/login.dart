import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:garbage_grabber/controllers/routes.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';
import '../../controllers/apihandler.dart';
import '../../controllers/setup_controller.dart';
import '../../widgets/error_handling.dart';
import '../../widgets/input_field.dart';
import 'package:http/http.dart ' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  SetupScreenController controller = Get.put(SetupScreenController());
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  Map sendingBody = {};

  Future<void> login(sendigBody) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.customerlogin;
      var response = await http.post(Uri.parse(uri), body: sendingBody);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {
        Map value = jsonDecode(response.body);

        if (value.containsKey('email')) {
          controller.errormailoccur(value['email'][0]);
        } else if (value.containsKey("non_field_errors")) {
          controller.errormailoccur(value['non_field_errors'][0]);
        }
        controller.isLoadingindicator();
      }
    } catch (e) {
      controller.isLoadingindicator();
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                key: _formKey1,
                child:
                    ListView(physics: const ClampingScrollPhysics(), children: [
                  SizedBox(
                    height: deviceHeight * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login',
                          style: AppFonts.poppinsBold
                              .copyWith(fontSize: AppFonts.largeFontSize)),
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
                        InputField(
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
                          suffix: null,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        InputField(
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
                                color: AppColors.iconColor),
                          ),
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
                          controller.isindicatorLoading
                              ? Container(
                                  height: deviceHeight * 0.052,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.primaryColor),
                                  child: Center(
                                    child: SizedBox(
                                      height: deviceHeight * 0.03,
                                      width: deviceWidth * 0.064,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppColors.planeColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: deviceHeight * 0.052,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.primaryColor),
                                  child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      onPressed: () async {
                                        final isvalid =
                                            _formKey1.currentState!.validate();
                                        if (isvalid) {
                                          FocusScope.of(context).unfocus();
                                          controller.isLoadingindicator();
                                          sendingBody = {
                                            "email": email.text,
                                            "password": password.text
                                          };
                                          await login(sendingBody);
                                        }
                                      },
                                      child: Text('Login',
                                          style: AppFonts.poppinsMedium
                                              .copyWith(
                                                  fontSize:
                                                      AppFonts.mediumFontSize,
                                                  color:
                                                      AppColors.planeColor))),
                                ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ?",
                                  style: AppFonts.poppinsRegular.copyWith()),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.register);
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: AppFonts.poppinsRegular.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      )),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
