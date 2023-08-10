import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:garbage_grabber/src/services/apihandler.dart';
import 'package:garbage_grabber/src/data/controllers/routes.dart';

import 'package:get/get.dart';

import '../../../../data/controllers/home/homescreen_controller.dart';
import '../../../../services/token_manager.dart';
import '../../../../widgets/calendar_dialog.dart';
import '../../../../widgets/dropdown.dart';
import '../../../../widgets/loading_dialog.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/fonts.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    Key? key,
    required this.image,
    required this.id,
    required this.price,
    required this.name,
    required this.plan,
    required this.email,
  }) : super(key: key);
  final String image;
  final int id;
  final double price;
  final String name;
  final String plan;
  final String email;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  HomeScreenController controller = Get.put(HomeScreenController());
  final storage = const FlutterSecureStorage();
  var items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  int quantity = 1;
  Map<String, dynamic>? paymentIntent;
  Map sendingpaymentdata = {};
  Future<void> verifyappointment() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);
      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.verifyappointment;

        var response = await http.post(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        }, body: {
          "quantity": quantity.toString(),
          "product_id": widget.id.toString(),
          "appointment_date_start": controller.sendinddate,
          "total_payment": controller.priceindouble.toString()
        });

        if (response.statusCode == 200) {
          await makePayment();
        } else if (response.statusCode == 400) {
          Get.back();
          lateappointment();
        } else {
          Get.back();
          showErrorDialog();
        }
      } else {
        Get.back();
        // ignore: use_build_context_synchronously
        showErrorDialog();
      }
    } catch (e) {
      Get.back();
      showErrorDialog();
    }
  }

  Future<void> makePayment() async {
    try {
      String amount = controller.payingprice ?? '0.0';
      paymentIntent = await createPaymentIntent(amount, 'USD');

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        appearance: PaymentSheetAppearance(
            shapes: const PaymentSheetShape(borderRadius: 10),
            colors:
                PaymentSheetAppearanceColors(primary: AppColors.primaryColor),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
                shapes: const PaymentSheetPrimaryButtonShape(blurRadius: 8),
                colors: PaymentSheetPrimaryButtonTheme(
                    light: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColors.primaryColor,
                  text: AppColors.planeColor,
                )))),
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.system,
        merchantDisplayName: 'Garbage Grabber',
      ));

      await displayPaymentSheet();

      // ignore: use_build_context_synchronously
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      double amountDouble = double.parse(amount);
      int amountInCents = (amountDouble * 100).round();
      final stirpeid = await storage.read(key: 'stripe_id');
      Map<String, dynamic> body = {
        "amount": amountInCents.toString(),
        "currency": currency,
        // "receipt_email": widget.email,
        "customer": stirpeid,
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer ${dotenv.env['secretkey']}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Get.back();
      } else {
        Get.back();
        showErrorDialog();
      }
      return jsonDecode(response.body);
    } catch (e) {
      showErrorDialog();
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      var paymentintents = await Stripe.instance
          .retrievePaymentIntent(paymentIntent!["client_secret"]);

      var details = paymentintents.toJson();

      if (details['status'] == 'Succeeded') {
        var id = details['id'];
        int unixTimestamp = int.parse(details['created']);
        DateTime dateTime =
            DateTime.fromMicrosecondsSinceEpoch(unixTimestamp * 1000);
        String formattedDateTime =
            dateTime.toIso8601String().replaceAll(" ", "T");
        // double totalpayment = details['amount'] / 100;

        Get.offNamed(AppRoutes.paymentsuccess, arguments: {
          'id': id,
          'amount': details['amount'] / 100,
          'created': int.parse(
            details['created'],
          ),
          'currency': details['currency']
        });
        sendingpaymentdata = {
          "quantity": quantity.toString(),
          "product_id": widget.id.toString(),
          "appointment_date_start": controller.sendinddate,
          "total_payment": (details['amount'] / 100).toString(),
          "transaction_id": id,
          "currency": details['currency'].toString(),
          "payment_at": formattedDateTime
        };

        await savepaymentdetails(sendingpaymentdata);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> savepaymentdetails(sendingpaymentdata) async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);
      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.registerappointment;

        var response = await http.post(Uri.parse(uri),
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
            body: sendingpaymentdata);

        if (response.statusCode == 200) {}
      } else {
        Get.back();

        showErrorDialog();
      }
    } catch (e) {
      Get.back();
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ProudctValidation(
          deviceHeight: MediaQuery.of(context).size.height,
          deviceWidth: MediaQuery.of(context).size.width,
          headertext: 'Error',
          errortext: 'Something went wrong',
        );
      },
    );
  }

  void lateappointment() {
    showDialog(
      context: context,
      builder: (context) {
        return ProudctValidation(
          deviceHeight: MediaQuery.of(context).size.height,
          deviceWidth: MediaQuery.of(context).size.width,
          headertext: 'Error',
          errortext: "Appointments for today can't be scheduled after 6 a.m.",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: SizedBox(
            height: deviceHeight * 0.875,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Image.asset(
                      widget.image,
                      height: deviceHeight * 0.3,
                      width: deviceWidth,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppFonts.poppinsRegular.copyWith(fontSize: 20),
                          ),
                          Flexible(
                            child: controller.pricechanged
                                ? Text(
                                    '\$${controller.totalprice}',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.poppinsMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 20),
                                  )
                                : Text(
                                    '\$${widget.price}',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.poppinsMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontSize: 20),
                                  ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(widget.plan,
                                style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: 17,
                                    color: AppColors.primaryColor
                                        .withOpacity(0.9))),
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Text('Quantity',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: 17))
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.19,
                        child: DropDown(
                            hintText: '    1',
                            currentSelectedValue: '1',
                            selectingCategory: items,
                            heightofCategory: deviceHeight * 0.3,
                            onSelecting: (value) {
                              int intValue = int.parse(value);
                              quantity = intValue;

                              double pricevalue =
                                  widget.price; // Convert string to int
                              double total = intValue * pricevalue;
                              String totalprice = total.toStringAsFixed(2);
                              controller.quantitycaclculation(totalprice);
                            },
                            formvalidation: (value) {}),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Text('Select pickup date',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: 17))
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
                            color: AppColors.fillColor),
                        child: MaterialButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                context: context,
                                builder: (context) => const CalendarDialog());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: AppColors.iconColor,
                              ),
                              SizedBox(
                                width: deviceWidth * 0.02,
                              ),
                              controller.datepicked
                                  ? Text(
                                      controller.date,
                                      style: AppFonts.poppinsRegular.copyWith(
                                          fontSize: AppFonts.smallFontSize,
                                          letterSpacing: 0.5),
                                    )
                                  : Text(
                                      'Pickup date',
                                      style: AppFonts.poppinsRegular.copyWith(
                                          fontSize: AppFonts.smallFontSize,
                                          color: AppColors.iconColor,
                                          letterSpacing: 0.5),
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.04,
                      ),
                      controller.ispriceChange
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: deviceHeight * 0.01,
                                      left: deviceWidth * 0.04,
                                      right: deviceWidth * 0.04),
                                  width: deviceWidth * 0.5,
                                  height: deviceHeight * 0.11,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: AppColors.pricecalcontainer
                                          .withOpacity(0.1)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Net Price',
                                            style: AppFonts.poppinsRegular,
                                          ),
                                          Text(
                                            '\$${controller.totalprice}',
                                            style: AppFonts.poppinsRegular,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Tax',
                                            style: AppFonts.poppinsRegular,
                                          ),
                                          Text(
                                            '8.5 %',
                                            style: AppFonts.poppinsRegular,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: deviceHeight * 0.005,
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: AppColors.primaryColor,
                                        height: 1,
                                      ),
                                      SizedBox(
                                        height: deviceHeight * 0.005,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: AppFonts.poppinsMedium,
                                          ),
                                          Text(
                                            '\$${controller.payingprice}',
                                            style: AppFonts.poppinsMedium,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Container(
                    height: deviceHeight * 0.05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor),
                    child: Builder(builder: (context) {
                      return MaterialButton(
                        onPressed: () async {
                          if (controller.isdatepicked == true &&
                              controller.ispriceChange == true) {
                            LoadingDialog.show(context);
                            verifyappointment();
                          } else if (controller.isdatepicked == false &&
                              controller.ispriceChange == false) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ProudctValidation(
                                    deviceHeight: deviceHeight,
                                    deviceWidth: deviceWidth,
                                    headertext: 'Required',
                                    errortext:
                                        'Select quantity and pickup date',
                                  );
                                });
                          } else if (controller.isdatepicked == false &&
                              controller.ispriceChange == true) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ProudctValidation(
                                    deviceHeight: deviceHeight,
                                    deviceWidth: deviceWidth,
                                    headertext: 'Required',
                                    errortext: 'Select pickup date',
                                  );
                                });
                          } else if (controller.isdatepicked == true &&
                              controller.ispriceChange == false) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ProudctValidation(
                                    deviceHeight: deviceHeight,
                                    deviceWidth: deviceWidth,
                                    headertext: 'Required',
                                    errortext: 'Select quantity',
                                  );
                                });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay ',
                              style: AppFonts.poppinsLightMedium.copyWith(
                                  color: AppColors.planeColor,
                                  fontSize: AppFonts.mediumFontSize),
                            ),
                            controller.ispriceChange
                                ? Text(
                                    '\$${controller.payingprice}',
                                    style: AppFonts.poppinsBold.copyWith(
                                        color: AppColors.planeColor,
                                        fontSize: AppFonts.mediumFontSize),
                                  )
                                : Text(
                                    '\$${widget.price}',
                                    style: AppFonts.poppinsBold.copyWith(
                                        color: AppColors.planeColor,
                                        fontSize: AppFonts.mediumFontSize),
                                  ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProudctValidation extends StatelessWidget {
  const ProudctValidation({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.headertext,
    required this.errortext,
  });

  final double deviceHeight;
  final double deviceWidth;
  final String headertext;
  final String errortext;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: deviceHeight * 0.18,
        child: Padding(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.05, right: deviceWidth * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.014,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(headertext,
                          style: AppFonts.poppinsMedium.copyWith(
                              color: AppColors.errorColor,
                              fontSize: AppFonts.errorDialogHead)),
                      SizedBox(
                        width: deviceWidth * 0.02,
                      ),
                      Icon(
                        Icons.error,
                        color: AppColors.errorColor,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(errortext,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.errorDialogBody)),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: deviceHeight * 0.04,
                    width: deviceWidth * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.errorColor),
                    child: MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'OK ',
                        style: AppFonts.poppinsLightMedium.copyWith(
                            color: AppColors.planeColor,
                            fontSize: AppFonts.mediumFontSize),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
