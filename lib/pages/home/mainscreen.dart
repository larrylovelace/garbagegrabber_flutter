import 'package:flutter/material.dart';
import 'package:garbage_grabber/pages/home/customerqr.dart';
import 'package:garbage_grabber/pages/home/homescreen.dart';
import 'package:garbage_grabber/pages/home/pickups/appointments.dart';
import 'package:garbage_grabber/pages/home/transactions.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: AppColors.secondaryColor,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) => const QRprofile());

            // Add your logic for the FAB button here
          },
          child: const Icon(UniconsLine.qrcode_scan),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 7,
          shape: const CircularNotchedRectangle(),
          child: GetBuilder<MainScreenController>(
            builder: (controller) {
              return SizedBox(
                height: deviceheight * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        controller.changeIndex(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            UniconsLine.home,
                            color: controller.currentIndex == 0
                                ? AppColors.primaryColor
                                : AppColors.iconColor,
                          ),
                          Text(
                            'Home',
                            style:
                                AppFonts.poppinsRegular.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        controller.changeIndex(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            UniconsLine.calendar_alt,
                            color: controller.currentIndex == 1
                                ? AppColors.primaryColor
                                : AppColors.iconColor,
                          ),
                          Text('Pickups',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: 12))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.06,
                    ),
                    MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        controller.changeIndex(2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            UniconsLine.bill,
                            color: controller.currentIndex == 2
                                ? AppColors.primaryColor
                                : AppColors.iconColor,
                          ),
                          Text('Payments',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: 12))
                        ],
                      ),
                    ),
                    MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        controller.changeIndex(3);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            UniconsLine.setting,
                            color: controller.currentIndex == 3
                                ? AppColors.primaryColor
                                : AppColors.iconColor,
                          ),
                          Text('Settings',
                              style: AppFonts.poppinsRegular
                                  .copyWith(fontSize: 12))
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        body: GetBuilder<MainScreenController>(
          builder: (controller) {
            return controller.toName(controller.currentIndex);
          },
        ));
  }
}

class MainScreenController extends GetxController {
  var currentIndex = 0;

  Widget toName(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const PickUpsShcedule();
      case 2:
        return const TransactionScreen();
      case 3:
        return const SizedBox();
      default:
        return Container();
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
