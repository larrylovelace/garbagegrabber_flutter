import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/controllers/routes.dart';

import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:garbage_grabber/widgets/dropdown.dart';
import 'package:garbage_grabber/widgets/input_field.dart';
import 'package:get/get.dart';

import '../../controllers/apihandler.dart';
import '../../controllers/setup_controller.dart';
import 'package:http/http.dart ' as http;

import '../../widgets/error_handling.dart';
import '../../widgets/error_snackbar.dart';

class FormFillScreen extends StatefulWidget {
  const FormFillScreen({super.key});

  @override
  State<FormFillScreen> createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  final storage = const FlutterSecureStorage();

  SetupScreenController controller = Get.put(SetupScreenController());

  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  var apartmentName = [
    'The Arbours of Hermitage',
    'Alta Lake Apartments',
    'Alta Farms at Cane Ridge',
    'Canyon Ridge Apartments',
    'Cedar Ridge',
    'Cherry Creek Apartments',
    'Highland at the Lake',
    'MAA Park Hermitage',
    'MAA Brentwood',
    'MAA Bellevue',
    'The Colonnade',
    'The Cove at Priest Lake',
    'Vintage at Burkitt Station',
    'Waterford Landing',
    'Waterford Crossing',
    'Waterleaf at Old Franklin',
    'Other'
  ];
  TextEditingController apartmentname = TextEditingController();
  TextEditingController apartmentnumber = TextEditingController();
  TextEditingController unitnumber = TextEditingController();
  TextEditingController whatfloornumber = TextEditingController();
  TextEditingController streetaddress = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  Map sendingDetails = {};

  Future<void> sendfromDetails(sendigdetails) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.sendfromData;
      var response = await http.post(Uri.parse(uri), body: sendingDetails);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        await storage.write(
            key: 'refreshtoken', value: data['token']['refresh'].toString());
        await storage.write(
            key: 'accesstoken', value: data['token']['access'].toString());
        controller.isLoadingindicator();
        Get.offAllNamed(AppRoutes.homescreen);
      } else {
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          'Error',
          'Something went wrong',
          Colors.red, // Custom background color
          Icons.error_rounded, // Custom icon
          Colors.red, // Custom icon color
        );
        controller.isLoadingindicator();
      }
    } catch (e) {
      print(e);
      controller.isLoadingindicator();
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  List<Step> getSteps() => [
        Step(
            state: controller.currentPosition > 0
                ? StepState.complete
                : StepState.indexed,
            isActive: controller.currentPosition >= 0,
            title: Text(
              'Apartment',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
            ),
            content: Builder(builder: (context) {
              double deviceHeight = MediaQuery.of(context).size.height;
              // double deviceWidth = MediaQuery.of(context).size.width;
              return GetBuilder<SetupScreenController>(
                builder: (controller) {
                  return Form(
                    key: _formKey4,
                    child: Column(
                      children: <Widget>[
                        Header(
                          deviceHeight: deviceHeight,
                          text: 'Select your apartment',
                        ),
                        DropDown(
                            currentSelectedValue: controller.dropDownValue,
                            selectingCategory: apartmentName,
                            heightofCategory: deviceHeight * 0.56,
                            onSelecting: (value) {
                              controller.onSelecting(value);
                              if (value != 'Other') {
                                apartmentname.text = value;
                              } else {
                                apartmentname.text = '';
                              }
                            },
                            formvalidation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required ';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        controller.apartmentothersValue
                            ? Column(
                                children: [
                                  Header(
                                    deviceHeight: deviceHeight,
                                    text: 'Apartment name',
                                  ),
                                  InputField(
                                    controller: apartmentname,
                                    isPrefix: false,
                                    errorText: null,
                                    hintText: 'Apartment name',
                                    keywordType: TextInputType.name,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.02,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Header(
                          deviceHeight: deviceHeight,
                          text: 'Apartment number',
                        ),
                        InputField(
                          controller: apartmentnumber,
                          isPrefix: false,
                          errorText: null,
                          hintText: 'Apartment number',
                          keywordType: TextInputType.number,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required ';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Header(
                          deviceHeight: deviceHeight,
                          text: 'Unit number',
                        ),
                        InputField(
                          controller: unitnumber,
                          isPrefix: false,
                          errorText: null,
                          hintText: 'Unit number',
                          keywordType: TextInputType.number,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required ';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Header(
                          deviceHeight: deviceHeight,
                          text: 'What floor',
                        ),
                        InputField(
                          controller: whatfloornumber,
                          isPrefix: false,
                          errorText: null,
                          hintText: 'What floor',
                          keywordType: TextInputType.number,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required ';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                        )
                      ],
                    ),
                  );
                },
              );
            })),
        Step(
            isActive: controller.currentPosition >= 1,
            title: Text(
              'Address',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
            ),
            content: Builder(builder: (context) {
              double deviceHeight = MediaQuery.of(context).size.height;
              // double deviceWidth = MediaQuery.of(context).size.width;
              return Form(
                key: _formKey5,
                child: Column(
                  children: <Widget>[
                    Header(
                      deviceHeight: deviceHeight,
                      text: 'Street address',
                    ),
                    InputField(
                      controller: streetaddress,
                      isPrefix: false,
                      errorText: null,
                      hintText: 'Street address',
                      keywordType: TextInputType.name,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required ';
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Header(
                      deviceHeight: deviceHeight,
                      text: 'City',
                    ),
                    InputField(
                      controller: city,
                      isPrefix: false,
                      errorText: null,
                      hintText: 'City',
                      keywordType: TextInputType.name,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required ';
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Header(
                      deviceHeight: deviceHeight,
                      text: 'State',
                    ),
                    InputField(
                      controller: state,
                      isPrefix: false,
                      errorText: null,
                      hintText: 'State',
                      keywordType: TextInputType.name,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required ';
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Header(
                      deviceHeight: deviceHeight,
                      text: 'Zip code',
                    ),
                    InputField(
                      controller: zipcode,
                      isPrefix: false,
                      errorText: null,
                      hintText: 'Zip code',
                      keywordType: TextInputType.number,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required ';
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                    )
                  ],
                ),
              );
            })),
      ];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.planeColor,
        appBar: AppBar(
          title: Text(
            'Fill your details',
            style: AppFonts.poppinsMedium
                .copyWith(fontSize: 22, color: Colors.black),
          ),
          centerTitle: true,
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
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  secondary: AppColors.planeColor,
                  primary: AppColors.primaryColor)),
          child: GetBuilder<SetupScreenController>(
            builder: (controller) {
              return Stepper(
                physics: const ClampingScrollPhysics(),
                type: StepperType.vertical,
                currentStep: controller.currentPosition,
                onStepContinue: () async {
                  final isValid = _formKey4.currentState!.validate();

                  if (isValid) {
                    final isLastStep =
                        controller.currentPosition == getSteps().length - 1;
                    if (isLastStep) {
                      final isValid = _formKey5.currentState!.validate();
                      if (isValid) {
                        controller.isLoadingindicator();
                        sendingDetails = {
                          "email": controller.sendemail,
                          "password": controller.password,
                          "appartment_complex_name": apartmentname.text,
                          "appartment_number": apartmentnumber.text,
                          "unit_number": unitnumber.text,
                          "floor_number": whatfloornumber.text,
                          "street_address": streetaddress.text,
                          "city": city.text,
                          "state": state.text,
                          "zipcode": zipcode.text,
                          "visitor_location": ''
                        };
                        print(sendingDetails);

                        await sendfromDetails(sendingDetails);
                      }
                      // Handle last step completion
                    } else {
                      _formKey4.currentState!.save(); // Save the form data
                      controller.onStepContinue();
                    }
                  }
                },
                onStepCancel: () {
                  final isfirstStep = controller.currentPosition == 0;
                  if (isfirstStep) {
                  } else {
                    controller.onStepCancel();
                  }
                },
                steps: getSteps(),
                controlsBuilder: (context, details) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: deviceHeight * 0.04,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: controller.isindicatorLoading
                              ? Container(
                                  height: deviceHeight * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.primaryColor),
                                  child: Center(
                                    child: SizedBox(
                                      height: deviceHeight * 0.03,
                                      width: deviceWidth * 0.064,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.4,
                                        color: AppColors.planeColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: deviceHeight * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.primaryColor),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    onPressed: () {
                                      details.onStepContinue!();
                                    },
                                    child: Text(
                                      'Next',
                                      style: AppFonts.poppinsMedium.copyWith(
                                          fontSize: AppFonts.mediumFontSize,
                                          color: AppColors.planeColor),
                                    ),
                                  ),
                                ),
                        ),
                        if (controller.currentPosition != 0)
                          SizedBox(
                            width: deviceWidth * 0.08,
                          ),
                        if (controller.currentPosition != 0)
                          Expanded(
                            child: Container(
                              height: deviceHeight * 0.05,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      AppColors.secondaryColor.withOpacity(1)),
                              child: MaterialButton(
                                onPressed: () {
                                  details.onStepCancel!();
                                },
                                child: Text(
                                  'Cancel',
                                  style: AppFonts.poppinsMedium.copyWith(
                                      fontSize: AppFonts.mediumFontSize,
                                      color: AppColors.cancelColor),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.deviceHeight,
    required this.text,
  });

  final double deviceHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: AppFonts.poppinsLightMedium.copyWith(),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * 0.015,
        ),
      ],
    );
  }
}
