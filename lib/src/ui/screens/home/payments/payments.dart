import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../../../data/controllers/home/payments/payments_controller.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/fonts.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  PaymentPageController paymentspagecontroller =
      Get.find<PaymentPageController>();

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
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
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            paymentspagecontroller.paymentdetails = null;

            return paymentspagecontroller.getTransactiondetails(context);
          },
          child: GetBuilder<PaymentPageController>(
            builder: (paymentspagecontroller) {
              return paymentspagecontroller.paymentdetails == null &&
                      paymentspagecontroller.nopayments == false
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  // ignore: unnecessary_null_comparison
                  : paymentspagecontroller.paymentdetails == null &&
                          paymentspagecontroller.nopayments == true
                      ? Center(
                          child: Text(
                            'No previous transactions found',
                            style: AppFonts.poppinsRegular,
                          ),
                        )
                      : NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) {
                            return [
                              SliverAppBar.medium(
                                elevation: 1,
                                pinned: false,
                                floating: false,
                                backgroundColor: AppColors.primaryColor,
                                flexibleSpace: Container(
                                  margin: EdgeInsets.only(
                                      top: deviceheight * 0.01,
                                      left: deviceWidth * 0.04,
                                      right: deviceWidth * 0.04),
                                  padding:
                                      EdgeInsets.only(left: deviceWidth * 0.03),
                                  height: deviceheight * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: AppColors.secondaryColor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '\$${paymentspagecontroller.paymentdetails!.grandTotal.toStringAsFixed(2)}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: AppFonts.poppinsMedium
                                                    .copyWith(
                                                        fontSize: 22,
                                                        letterSpacing: 1),
                                              )
                                            ],
                                          ),
                                          Text(
                                            'Total Payments',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.poppinsRegular
                                                .copyWith(
                                                    fontSize:
                                                        AppFonts.smallFontSize),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: CustomScrollView(slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              final formattedDateTime = _formatDateTime(
                                  paymentspagecontroller
                                      .paymentdetails!.data[index].paymentAt);
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
                                          paymentspagecontroller.paymentdetails!
                                              .data[index].totalPayment,
                                          paymentspagecontroller.paymentdetails!
                                              .data[index].product.name,
                                          paymentspagecontroller.paymentdetails!
                                              .data[index].product.plan,
                                          deviceheight,
                                          deviceWidth)));
                            },
                                    childCount: paymentspagecontroller
                                        .paymentdetails!.data.length))
                          ]),
                        );
            },
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
