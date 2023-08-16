import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_grabber/src/data/controllers/routes.dart';

import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/fonts.dart';
import '../screenhandler.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  final MainScreenController mainScreenController =
      Get.find<MainScreenController>();
  // var paidamount = Get.arguments['amount'];
  // int unixTimestamp = Get.arguments['created'];

  var paidamount = '22';
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight * 0.01,
          backgroundColor: AppColors.kBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/order_complete.svg',
                    height: deviceHeight * 0.3,
                  ),
                  SizedBox(
                    height: deviceHeight * 0.1,
                  ),
                  Text(
                    'Payment Successfull !',
                    style: AppFonts.poppinsRegular.copyWith(
                        fontSize: AppFonts.mediumFontSize,
                        color: AppColors.kPrimaryColor),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Amount Paid',
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.smallFontSize),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.04,
                      ),
                      Container(
                        width: deviceWidth * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: AppColors.kHighlightColor.withOpacity(0.1)),
                        child: Center(
                          child: Text(
                            '\$$paidamount',
                            style: AppFonts.poppinsBold.copyWith(
                                fontSize: AppFonts.mediumFontSize,
                                color: AppColors.kHighlightColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Container(
                      height: deviceHeight * 0.05,
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.08, right: deviceWidth * 0.08),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.kPrimaryColor),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          mainScreenController.resetController();
                          Get.offAllNamed(AppRoutes.screenhandler);
                        },
                        child: Text(
                          'Finish',
                          style: AppFonts.poppinsLightMedium.copyWith(
                              color: AppColors.kWhiteColor,
                              fontSize: AppFonts.largeFontSize),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
