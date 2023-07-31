import 'package:flutter/material.dart';
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
  var paidamount = Get.arguments['amount'];
  int unixTimestamp = Get.arguments['created'];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.planeColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight * 0.01,
          backgroundColor: AppColors.planeColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceHeight * 0.14,
                width: deviceWidth * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 45,
                    color: AppColors.planeColor,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Successful ',
                    style: AppFonts.poppinsMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Text(
                    'Your payment was done successfully',
                    style: AppFonts.poppinsRegular
                        .copyWith(fontSize: AppFonts.smallFontSize),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.67,
                    decoration: BoxDecoration(
                        color: AppColors.fillColor.withOpacity(0.05),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Text(
                              'Amount Paid',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: AppFonts.smallFontSize),
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * 0.01,
                          ),
                          Flexible(
                            child: Text(
                              '\$$paidamount',
                              style: AppFonts.poppinsMedium
                                  .copyWith(fontSize: AppFonts.mediumFontSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.04,
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                      height: deviceHeight * 0.048,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          mainScreenController.resetController();
                          Get.offAllNamed(AppRoutes.screenhandler);
                        },
                        child: Text(
                          'OK',
                          style: AppFonts.poppinsBold.copyWith(
                              color: AppColors.planeColor,
                              fontSize: AppFonts.mediumFontSize),
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
