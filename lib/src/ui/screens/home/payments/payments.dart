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
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceheight > 1000 ? 100 : 50,
          title: Row(
            children: [
              Text(
                'Payments',
                style: AppFonts.poppinsBold.copyWith(
                  fontSize: AppFonts.largeFontSize,
                  color: AppColors.kBlackColor,
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
        ),
        body: RefreshIndicator(
          color: AppColors.kPrimaryColor,
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
                        color: AppColors.kPrimaryColor,
                      ),
                    )
                  // ignore: unnecessary_null_comparison
                  : paymentspagecontroller.paymentdetails == null &&
                          paymentspagecontroller.nopayments == true
                      ? Center(
                          child: Text(
                            'No previous transactions found',
                            style: AppFonts.poppinsRegular
                                .copyWith(fontSize: AppFonts.smallFontSize),
                          ),
                        )
                      : CustomScrollView(slivers: [
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                            final formattedDateTime = _formatDateTime(
                                paymentspagecontroller
                                    .paymentdetails!.data[index].paymentAt);
                            return Container(
                              margin: EdgeInsets.only(
                                top: deviceheight * 0.03,
                                left: deviceWidth * 0.03,
                                right: deviceWidth * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kWhiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.5,
                                      blurStyle: BlurStyle.solid,
                                      color: AppColors.kBlackColor
                                          .withOpacity(0.1),
                                      offset: const Offset(0, 0.8))
                                ],
                              ),
                              child: buildPaymentListTile(
                                  formattedDateTime,
                                  paymentspagecontroller
                                      .paymentdetails!.data[index].totalPayment,
                                  paymentspagecontroller
                                      .paymentdetails!.data[index].product.name,
                                  paymentspagecontroller
                                      .paymentdetails!.data[index].product.plan,
                                  deviceheight,
                                  deviceWidth),
                            );
                          },
                                  childCount: paymentspagecontroller
                                      .paymentdetails!.data.length))
                        ]);
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
          style:
              AppFonts.poppinsRegular.copyWith(fontSize: AppFonts.minimalText),
        ),
        Text(subtitle,
            style: AppFonts.poppinsMedium.copyWith(
              fontSize: AppFonts.smallFontSize,
              color: AppColors.kPrimaryColor.withOpacity(0.9),
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
          style: AppFonts.poppinsLightMedium.copyWith(
              fontSize: AppFonts.smallFontSize,
              color: AppColors.kHighlightColor),
        ),
        SizedBox(width: deviceWidth * 0.015),
        // CircleAvatar(
        //   radius: deviceHeight * 0.014,
        //   backgroundColor:AppColors.kPrimaryColor,
        //   child: Icon(
        //     Icons.check,
        //     color: AppColors.planeColor,
        //     size: 15,
        //   ),
        // ),
      ],
    ),
  );
}

String _formatDateTime(String backendDateTime) {
  final dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(backendDateTime);
  return DateFormat('MMM d y, hh:mm a').format(dateTime);
}
