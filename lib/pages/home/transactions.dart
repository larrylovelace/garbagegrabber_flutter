import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/pages/home/product_detail.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/apihandler.dart';
import '../../controllers/token_manager.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';

import 'package:http/http.dart ' as http;

import '../../widgets/error_handling.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  ScrollController scrollController = ScrollController();
  final storage = const FlutterSecureStorage();
  List paymentdetails = [];
  double totaltransaction = 0;
  double recenttransaction = 0;
  bool dataempty = false;
  Future<void> getTransactiondetails() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.registerappointment;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['data'].isEmpty) {
            setState(() {
              dataempty = true;
            });
          } else {
            paymentdetails = data['data'];
            totaltransaction = data['grand_total'] ?? 0;
            recenttransaction = data['data'][0]['total_payment'] ?? 0;
          }

          setState(() {});
        } else {
          Get.back();
          showErrorDialog();
        }
      }
    } catch (e) {
      print(e);
      Get.back();
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  @override
  void initState() {
    getTransactiondetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          'Transactions',
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
        elevation: 0.2,
        backgroundColor: AppColors.planeColor,
      ),
      body: Center(
          child: paymentdetails.isEmpty && dataempty == false
              ? CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              : paymentdetails.isEmpty && dataempty == true
                  ? Text(
                      'You have not made any transactions.',
                      style: AppFonts.poppinsLightMedium.copyWith(),
                    )
                  : Column(
                      children: [
                        Card(
                          elevation: 0.5,
                          color: AppColors.secondaryColor,
                          margin: EdgeInsets.only(
                              top: deviceheight * 0.01,
                              left: deviceWidth * 0.02,
                              right: deviceWidth * 0.02),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: deviceheight * 0.01,
                                left: deviceWidth * 0.02,
                                right: deviceWidth * 0.02),
                            height: deviceheight * 0.12,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColors.secondaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: deviceWidth * 0.45,
                                  height: deviceheight * 0.08,
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.payment_outlined,
                                              color: AppColors.iconColor,
                                            ),
                                            SizedBox(
                                              width: deviceWidth * 0.02,
                                            ),
                                            Text(
                                              'Total',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: AppFonts.poppinsMedium
                                                  .copyWith(
                                                      fontSize: AppFonts
                                                          .mediumFontSize),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '\$${totaltransaction.toStringAsFixed(2)}',
                                              style: AppFonts.poppinsBold
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: AppFonts
                                                          .mediumFontSize),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.45,
                                  height: deviceheight * 0.08,
                                  child: Card(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.today_outlined,
                                              color: AppColors.iconColor,
                                            ),
                                            SizedBox(
                                              width: deviceWidth * 0.02,
                                            ),
                                            Text(
                                              'Recent',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: AppFonts.poppinsMedium
                                                  .copyWith(
                                                      fontSize: AppFonts
                                                          .mediumFontSize),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '\$$recenttransaction',
                                              style: AppFonts.poppinsBold
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: AppFonts
                                                          .mediumFontSize),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CupertinoScrollbar(
                            thumbVisibility: true,
                            radius: const Radius.circular(10),
                            controller: scrollController,
                            child: ListView.builder(
                                itemCount: paymentdetails.length,
                                itemBuilder: (context, index) {
                                  final formattedDateTime = _formatDateTime(
                                      paymentdetails[index]['payment_at']);
                                  return SizedBox(
                                      height: deviceheight * 0.13,
                                      child: Card(
                                          margin: EdgeInsets.only(
                                              top: deviceheight * 0.02,
                                              left: deviceWidth * 0.05,
                                              right: deviceWidth * 0.05),
                                          elevation: 0.5,
                                          color: AppColors.planeColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: buildPaymentListTile(
                                              paymentdetails[index]
                                                  ['product_id'],
                                              formattedDateTime,
                                              paymentdetails[index]
                                                  ['total_payment'],
                                              deviceheight,
                                              deviceWidth)));
                                }),
                          ),
                        ),
                      ],
                    )),
    );
  }
}

Widget buildPaymentListTile(int productId, String formattedDateTime,
    double totalPayment, double deviceHeight, double deviceWidth) {
  String title;
  String subtitle;

  if (productId == 1) {
    title = '1 Standard Bag';
    subtitle = 'One time';
  } else if (productId == 2) {
    title = '2 Standard Bags';
    subtitle = 'One time';
  } else if (productId == 3) {
    title = '1 Standard Bag';
    subtitle = 'Monthly';
  } else {
    title = '2 Standard Bags';
    subtitle = 'Monthly';
  }

  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    onTap: () {},
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.poppinsMedium.copyWith(fontSize: 15),
        ),
        Text(
          subtitle,
          style: AppFonts.poppinsRegular.copyWith(
            color: AppColors.primaryColor,
            fontSize: AppFonts.smallFontSize,
          ),
        ),
        SizedBox(height: deviceHeight * 0.015),
        Text(
          formattedDateTime,
          style: AppFonts.poppinsRegular.copyWith(
            fontSize: AppFonts.snackBarfontsmall,
            color: AppColors.iconColor,
          ),
        ),
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '\$ $totalPayment',
          style:
              AppFonts.poppinsMedium.copyWith(fontSize: AppFonts.smallFontSize),
        ),
        SizedBox(width: deviceWidth * 0.02),
        CircleAvatar(
          radius: 9,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.check,
            color: AppColors.planeColor,
            size: 15,
          ),
        ),
      ],
    ),
  );
}

String _formatDateTime(String backendDateTime) {
  final dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(backendDateTime);
  return DateFormat('MMM d y, hh:mm a').format(dateTime);
}
