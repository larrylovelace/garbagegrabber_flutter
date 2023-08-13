import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/src/data/controllers/routes.dart';
import 'package:garbage_grabber/src/ui/screens/home/screenhandler.dart';

import 'package:garbage_grabber/src/widgets/start/dropdown.dart';
import 'package:garbage_grabber/src/widgets/start/input_field.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../services/apihandler.dart';
import '../../../data/controllers/start/setup_controller.dart';
import '../../../data/models/address.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/snackbars/error_handling.dart';
import '../../../widgets/snackbars/error_snackbar.dart';
import '../../../widgets/global/loading_dialog.dart';

class FormFillScreen extends StatefulWidget {
  const FormFillScreen({super.key});

  @override
  State<FormFillScreen> createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> searchResults = [];
  List<String> descriptions = [];
  List<String> placeid = [];
  String placeno = '';
  String email = Get.arguments['email'];
  String key = Get.arguments['password'];
  final storage = const FlutterSecureStorage();
  Map accountdetails = {};
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
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  final MainScreenController mainScreenController =
      Get.find<MainScreenController>();
  Map sendingDetails = {};
  Future<void> getaccountdetails() async {
    String uri = APIConstants.baseURI + APIConstants.getAccountDetails;
    var response = await http.post(Uri.parse(uri), body: {
      "email": email,
      "password": key,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      accountdetails = data;
    } else {
      Get.back();
      Get.back();
      // ignore: use_build_context_synchronously
      CustomSnackBar.show(
        context,
        'Error',
        'Something went wrong',
        AppColors.errorColor, // Custom background color
        Icons.error_rounded, // Custom icon
        AppColors.errorColor, // Custom icon color
      );
    }
  }

  Future<void> createCustomerStripe() async {
    try {
      String uri = APIConstants.createCustomerStripe;

      var response = await http.post(Uri.parse(uri), headers: {
        "Authorization": "Bearer ${dotenv.env['secretkey']}",
      }, body: {
        'name':
            '${accountdetails['first_name']} ${accountdetails['last_name']}',
        'email': accountdetails['email'],
        'phone': accountdetails['phone_number'],
        'address[city]': city.text,
        'address[country]': 'US',
        'address[line1]': streetaddress.text,
        'address[postal_code]': zipcode.text,
        'address[state]': state.text,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storage.write(key: 'stripe_id', value: data['id'].toString());
        sendingDetails = {
          "stripe_id": data['id'].toString(),
          "email": email,
          "password": key,
          "appartment_complex_name": apartmentname.text,
          "appartment_number": apartmentnumber.text,
          "unit_number": unitnumber.text,
          "floor_number": whatfloornumber.text,
          "street_address": streetaddress.text,
          "city": city.text,
          "state": state.text,
          "zipcode": zipcode.text,
          "lattitude": latitude.text,
          "longitude": longitude.text,
          "place_id": placeno,
        };

        await sendfromDetails(sendingDetails);
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendfromDetails(sendigdetails) async {
    try {
      String uri = APIConstants.baseURI + APIConstants.sendFormData;
      var response = await http.post(Uri.parse(uri), body: sendingDetails);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        await storage.write(
            key: 'refreshtoken', value: data['token']['refresh'].toString());
        await storage.write(
            key: 'accesstoken', value: data['token']['access'].toString());
        Get.back();
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
            context,
            'Success',
            'Welcome to Garbage Grabber',
            AppColors.primaryColor, // Custom background color
            Icons.check, // Custom icon
            AppColors.primaryColor // Custom icon color
            );

        mainScreenController.resetController();
        Get.offAllNamed(AppRoutes.screenhandler);
      } else {
        Get.back();
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          'Error',
          'Something went wrong',
          AppColors.errorColor, // Custom background color
          Icons.error_rounded, // Custom icon
          AppColors.errorColor, // Custom icon color
        );
      }
    } catch (e) {
      Get.back();
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> placeAutoComplete(String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "components": "country:us",
      "types": "establishment",
      "key": "${dotenv.env['placeskey']}",
    });
    String? response = await fetchUrl(uri);
    if (response != null) {
      final data = jsonDecode(response);

      final predictions = data['predictions'];

      setState(() {
        descriptions = predictions
            .map<String>((prediction) => prediction['description'] as String)
            .toList();

        placeid = predictions
            .map<String>((prediction) => prediction['place_id'] as String)
            .toList();
      });

      // ignore: use_build_context_synchronously
      showModalBottomSheet(
          enableDrag: true,
          isDismissible: true,
          backgroundColor: AppColors.secondaryColor,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          context: context,
          builder: (context) {
            double deviceHeight = MediaQuery.of(context).size.height;
            double deviceWidth = MediaQuery.of(context).size.width;
            return descriptions.isNotEmpty
                ? SizedBox(
                    height: deviceHeight * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Text(
                          'Select one from the following',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: AppFonts.poppinsMedium
                              .copyWith(fontSize: AppFonts.mediumFontSize),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Expanded(
                          child: CupertinoScrollbar(
                            thumbVisibility: true,
                            radius: const Radius.circular(10),
                            controller: scrollController,
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: descriptions.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    margin: EdgeInsets.only(
                                      top: deviceHeight * 0.015,
                                      bottom: deviceHeight * 0.015,
                                      left: deviceWidth * 0.06,
                                      right: deviceWidth * 0.06,
                                    ),
                                    child: ListTile(
                                        onTap: () {
                                          LoadingDialog.show(context);
                                          placeno = placeid[index];
                                          fetchGeocodingData(placeno);
                                        },
                                        contentPadding: EdgeInsets.only(
                                            left: deviceWidth * 0.01),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        title: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.iconColor,
                                            ),
                                            SizedBox(
                                              width: deviceWidth * 0.02,
                                            ),
                                            Flexible(
                                              child: Text(
                                                descriptions[index],
                                                style: AppFonts.poppinsRegular
                                                    .copyWith(
                                                        letterSpacing: 0.2,
                                                        fontSize: AppFonts
                                                            .smallFontSize),
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: deviceHeight * 0.1,
                    child: Center(
                      child: Text(
                        'Aparmtent  not found',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.poppinsLightMedium
                            .copyWith(fontSize: AppFonts.mediumFontSize),
                      ),
                    ),
                  );
          });
    }
  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Get.back();
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  void fetchGeocodingData(String placeid) async {
    final String apiKey = '${dotenv.env['geocodingkey']}';
    String placeId = placeid;

    final Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey');

    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        _formKey4.currentState!.save(); // Save the form data
        controller.onStepContinue();
        final data = json.decode(response.body);
        final storeData = StoreData.fromJson(data);

        // Call parseAddressComponents() after getting the response
        final parsedComponents =
            parseAddressComponents(storeData.formattedAddress);

        streetaddress.text = parsedComponents['streetAddress'] ?? '';
        city.text = parsedComponents['city'] ?? '';
        state.text = parsedComponents['state'] ?? '';
        zipcode.text = parsedComponents['zipCode'] ?? '';
        latitude.text = storeData.latitude.toString();
        longitude.text = storeData.longitude.toString();
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Map<String, String> parseAddressComponents(String address) {
    final RegExp regex = RegExp(r'^(.*?),\s*(.*?),\s*(.*?)\s+(\d{5}),.*$');
    final RegExpMatch? match = regex.firstMatch(address);

    if (match != null) {
      String? streetAddress = match.group(1)?.trim();
      String? city = match.group(2)?.trim();
      String? state = match.group(3)?.trim();
      String? zipCode = match.group(4)?.trim();

      return {
        'streetAddress': streetAddress ?? '',
        'city': city ?? '',
        'state': state ?? '',
        'zipCode': zipCode ?? '',
      };
    }

    // Return an empty map if the address doesn't match the expected format
    return {};
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
                            hintText: '    Select your apartment',
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
                                    readonly: false,
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
                          readonly: false,
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
                          readonly: false,
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
                          readonly: false,
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
                      readonly: true,
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
                      readonly: true,
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
                      readonly: true,
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
                      readonly: true,
                      controller: zipcode,
                      isPrefix: false,
                      errorText: null,
                      hintText: 'Zip code',
                      keywordType: TextInputType.number,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required ';
                        } else if (value.length != 5) {
                          return 'Zipcode is of 5 digits';
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
  void initState() {
    getaccountdetails();

    super.initState();
  }

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
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).unfocus();
                        // ignore: use_build_context_synchronously
                        LoadingDialog.show(context);
                        await createCustomerStripe();
                      }
                      // Handle last step completion
                    } else {
                      LoadingDialog.show(context);
                      await placeAutoComplete(apartmentname.text);
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
                          child: Container(
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
                                  color: AppColors.cancelButtonColor),
                              child: MaterialButton(
                                onPressed: () {
                                  details.onStepCancel!();
                                },
                                child: Text(
                                  'Cancel',
                                  style: AppFonts.poppinsMedium.copyWith(
                                      fontSize: AppFonts.mediumFontSize,
                                      color: AppColors.planeColor),
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
