import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/models/payments.dart';
import 'package:garbage_grabber/pages/home/product_detail.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import '../../controllers/api_cache.dart';
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
  PaymentData? paymentdetails;
  ScrollController scrollController = ScrollController();
  final storage = const FlutterSecureStorage();

  double totaltransaction = 0;
  double recenttransaction = 0;
  bool dataempty = false;
  bool nopayments = false;
  Future<void> getTransactiondetails() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.transactions;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['grand_total'] == null) {
            setState(() {
              nopayments = true;
            });
          } else {
            paymentdetails = PaymentData.fromJson(data);
            setState(() {});
          }
        } else {
          Get.back();
          showErrorDialog();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
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
    const cacheKey = 'page_2';
    if (ApiCache.apiCache.containsKey(cacheKey)) {
      paymentdetails = ApiCache.apiCache[cacheKey];
    } else {
      getTransactiondetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Payments',
                style: AppFonts.poppinsMedium
                    .copyWith(fontSize: 22, color: AppColors.planeColor),
              ),
            ],
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () {
            setState(() {
              paymentdetails = null;
            });
            return getTransactiondetails();
          },
          child: paymentdetails == null && nopayments == false
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              // ignore: unnecessary_null_comparison
              : paymentdetails == null && nopayments == true
                  ? Center(
                      child: Text(
                        'No previous transactions found',
                        style: AppFonts.poppinsRegular,
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar.medium(
                          backgroundColor: AppColors.primaryColor,
                          flexibleSpace: Container(
                            margin: EdgeInsets.only(
                                top: deviceheight * 0.01,
                                left: deviceWidth * 0.04,
                                right: deviceWidth * 0.04),
                            height: deviceheight * 0.1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: AppColors.secondaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          UniconsLine.bill,
                                          color: AppColors.iconColor,
                                        ),
                                        SizedBox(
                                          width: deviceWidth * 0.02,
                                        ),
                                        Text(
                                          'Total',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppFonts.poppinsRegular
                                              .copyWith(
                                                  fontSize:
                                                      AppFonts.mediumFontSize),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '\$${paymentdetails!.grandTotal.toStringAsFixed(2)}',
                                      style: AppFonts.poppinsBold.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: AppFonts.mediumFontSize),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          style: AppFonts.poppinsRegular
                                              .copyWith(
                                                  fontSize:
                                                      AppFonts.mediumFontSize),
                                        )
                                      ],
                                    ),
                                    Text(
                                      '\$${paymentdetails!.data[0].totalPayment}',
                                      style: AppFonts.poppinsBold.copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: AppFonts.mediumFontSize),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          final formattedDateTime = _formatDateTime(
                              paymentdetails!.data[index].paymentAt);
                          return SizedBox(
                              height: deviceheight * 0.13,
                              child: Card(
                                  margin: EdgeInsets.only(
                                      top: deviceheight * 0.02,
                                      left: deviceWidth * 0.04,
                                      right: deviceWidth * 0.04),
                                  elevation: 0.5,
                                  color: AppColors.planeColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: buildPaymentListTile(
                                      formattedDateTime,
                                      paymentdetails!.data[index].totalPayment,
                                      paymentdetails!.data[index].product.name,
                                      paymentdetails!.data[index].product.plan,
                                      deviceheight,
                                      deviceWidth)));
                        }, childCount: paymentdetails!.data.length))
                      ],
                    ),
        ));
  }
}

Widget buildPaymentListTile(String formattedDateTime, double totalPayment,
    String title, String subtitle, double deviceHeight, double deviceWidth) {
  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    onTap: () {},
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.poppinsLightMediumsnackBar.copyWith(
            fontSize: AppFonts.smallFontSize,
          ),
        ),
        Text(subtitle,
            style: AppFonts.poppinsMedium.copyWith(
              fontSize: AppFonts.smallFontSize,
              color: AppColors.primaryColor.withOpacity(0.9),
            )),
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
          '\$$totalPayment',
          style: AppFonts.poppinsLightMedium
              .copyWith(fontSize: AppFonts.smallFontSize),
        ),
        SizedBox(width: deviceWidth * 0.015),
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
