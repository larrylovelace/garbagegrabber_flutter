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
                      : CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                final month = formatMonth(paymentspagecontroller
                                    .paymentdetails!.data[index].paymentAt);
                                final date = formatDate(paymentspagecontroller
                                    .paymentdetails!.data[index].paymentAt);
                                final time = formatTime(paymentspagecontroller
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
                                      paymentspagecontroller.paymentdetails!
                                          .data[index].totalPayment,
                                      paymentspagecontroller.paymentdetails!
                                          .data[index].product.name,
                                      paymentspagecontroller.paymentdetails!
                                          .data[index].product.plan,
                                      paymentspagecontroller
                                          .paymentdetails!.data[index].quantity,
                                      month,
                                      date,
                                      time,
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

Widget buildPaymentListTile(
    double totalPayment,
    String title,
    String subtitle,
    int quantity,
    String month,
    String date,
    String time,
    double deviceHeight,
    double deviceWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: deviceHeight * 0.015, vertical: deviceHeight * 0.015),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.03),
          decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month,
                style: AppFonts.poppinsRegular.copyWith(
                    fontSize: AppFonts.smallFontSize,
                    color: AppColors.kPrimaryColor),
              ),
              Text(
                date,
                style: AppFonts.poppinsBold.copyWith(
                    fontSize: AppFonts.smallFontSize,
                    color: AppColors.kPrimaryColor),
              ),
            ],
          ),
        ),
        SizedBox(
          width: deviceWidth * 0.04,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: AppFonts.poppinsRegular
                      .copyWith(fontSize: AppFonts.minimalText),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  subtitle,
                  style: AppFonts.poppinsMedium.copyWith(
                      fontSize: AppFonts.smallFontSize,
                      color: AppColors.kPrimaryColor),
                ),
                SizedBox(
                  width: deviceWidth * 0.4,
                ),
                Text(
                  '\$$totalPayment',
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.poppinsLightMedium.copyWith(
                      fontSize: AppFonts.mediumtext,
                      color: AppColors.kHighlightColor),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.005,
            ),
            Text(
              time,
              style: AppFonts.poppinsRegular.copyWith(
                fontSize: AppFonts.snackBarfontsmall,
                color: AppColors.iconColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

String formatMonth(String backendDateTime) {
  final dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(backendDateTime);
  return DateFormat('MMM').format(dateTime);
}

String formatDate(String backendDateTime) {
  final dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(backendDateTime);
  return DateFormat('d').format(dateTime);
}

String formatTime(String backendDateTime) {
  final dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(backendDateTime);
  return DateFormat('hh:mm a').format(dateTime);
}
