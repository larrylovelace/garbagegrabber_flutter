import 'package:flutter/material.dart';
import 'package:garbage_grabber/controllers/page%20controllers/pickups.dart';
import 'package:garbage_grabber/pages/home/pickups/pickups.dart';
import 'package:garbage_grabber/pages/home/customerqr.dart';
import 'package:garbage_grabber/pages/home/homescreen.dart';

import 'package:garbage_grabber/pages/home/transactions.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../controllers/page controllers/homescreen.dart';
import '../../controllers/page controllers/payments.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    // Call getHomeScreeData() only once during initialization
    homePageController.loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    double deviceheight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<MainScreenController>().currentIndex != 0) {
          Get.find<MainScreenController>().changeIndex(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
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
            // Get the current page widget based on the current index
            Widget currentPage = controller.getPage(controller.currentIndex);

            // Fetch data for the current page if it has not been fetched yet
            controller.fetchDataForPage(context, controller.currentIndex);

            return currentPage;
          },
        ),
      ),
    );
  }
}

class MainScreenController extends GetxController {
  final PickupPageController pickupPageController =
      Get.put(PickupPageController());
  final PaymentPageController paymentPageController =
      Get.put(PaymentPageController());
  var currentIndex = 0;

  // List of pages
  final List<Widget> pages = [
    const HomeScreen(),
    const PickUpsShcedule(),
    const TransactionScreen(),
    const SizedBox(),
  ];

  // List to keep track of whether data has been fetched for each page
  final List<bool> hasDataFetched = List.filled(4, false);

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  // Method to get the page widget based on the index
  Widget getPage(int index) {
    return pages[index];
  }

  // Method to fetch data for a specific page
  void fetchDataForPage(BuildContext context, index) {
    if (!hasDataFetched[index]) {
      // Fetch data for the page based on the index
      // For example:
      // if (index == 0) {
      //   // Fetch data for HomeScreen
      //   // homeData = await ApiService.fetchHomeData();
      // }
      if (index == 1) {
        pickupPageController.pickupschedule(context);
        // Fetch data for PickUpsShcedule
      } else if (index == 2) {
        // Fetch data for TransactionScreen
        paymentPageController.getTransactiondetails(context);
      }

      // Mark the page as data fetched
      hasDataFetched[index] = true;

      // Update the UI to rebuild the page with the fetched data
    }
  }
}
