import 'package:flutter/material.dart';

import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:garbage_grabber/widgets/dropdown.dart';
import 'package:garbage_grabber/widgets/input_field.dart';
import 'package:get/get.dart';

import '../../controllers/setup_controller.dart';

class FormFillScreen extends StatefulWidget {
  const FormFillScreen({super.key});

  @override
  State<FormFillScreen> createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
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
                onStepContinue: () {
                  final isValid = _formKey4.currentState!.validate();

                  if (isValid) {
                    final isLastStep =
                        controller.currentPosition == getSteps().length - 1;
                    if (isLastStep) {
                      final isValid = _formKey5.currentState!.validate();
                      if (isValid) {}
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ))),
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
                        if (controller.currentPosition != 0)
                          SizedBox(
                            width: deviceWidth * 0.08,
                          ),
                        if (controller.currentPosition != 0)
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.secondaryColor.withOpacity(1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ))),
                              onPressed: () {
                                details.onStepCancel!();
                              },
                              child: Text(
                                'Cancel',
                                style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: AppFonts.mediumFontSize,
                                    color: Colors.black87),
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
