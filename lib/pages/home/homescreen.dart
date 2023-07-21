import 'package:flutter/material.dart';

import 'package:garbage_grabber/models/products.dart';

import 'package:garbage_grabber/pages/home/product_detail.dart';

import 'package:garbage_grabber/utils/colors.dart';

import 'package:garbage_grabber/utils/fonts.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:percent_indicator/percent_indicator.dart';

import '../../controllers/homescreen_controller.dart';
import '../../controllers/page controllers/homescreen.dart';
import '../../models/currentappointment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final HomePageController homecontroller = Get.find<HomePageController>();

  List<String> images = [
    'assets/Onebag.png',
    'assets/Onebag.png',
    'assets/Onebag.png',
    'assets/Onebag.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    int countPickupDatesAfterCurrentDate(List<Pickup> pickups) {
      DateTime currentDate = DateTime.now();
      int count = 0;

      for (Pickup pickup in pickups) {
        DateTime pickupDate = DateTime.parse(pickup.pickupDate);

        if (pickupDate.isAfter(currentDate)) {
          count++;
        }
      }

      return count;
    }

    return GetBuilder<HomePageController>(builder: (homecontroller) {
      return ValueListenableBuilder<Box<dynamic>>(
          valueListenable: Hive.box('homedata').listenable(),
          builder: (context, box, _) {
     
            if (box.isEmpty) {
              return Scaffold(
                backgroundColor: AppColors.secondaryColor,
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            } else {
              final products = box.get('homedata') as Products;
              String firstname = products.firstname;

              final productsdatas = products.productDatas;

              return Scaffold(
                backgroundColor: AppColors.secondaryColor,
                appBar: AppBar(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Hi $firstname',
                      style: AppFonts.poppinsBold
                          .copyWith(fontSize: AppFonts.largeFontSize),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: deviceWidth * 0.02),
                        child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: Image.asset('assets/notification.png',
                                height: deviceHeight * 0.028,
                                width: deviceWidth * 0.2,
                                color: AppColors.planeColor)),
                      ),
                    ]),
                body: RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () {
                    return homecontroller.getHomeScreeData(context);
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          homecontroller.currentAppointment == null
                              ? const SizedBox()
                              : Container(
                                  width: deviceWidth,
                                  height: deviceHeight * 0.23,
                                  margin: EdgeInsets.only(
                                      bottom: deviceHeight * 0.03),
                                  child: Stack(children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: deviceWidth * 0.04,
                                        right: deviceWidth * 0.04,
                                        bottom: deviceWidth * 0.1,
                                      ),
                                      height: deviceHeight * 0.12,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Card(
                                          elevation: 0.5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: deviceWidth * 0.01,
                                              left: deviceWidth * 0.03,
                                              right: deviceWidth * 0.03),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: deviceWidth * 0.04),
                                            height: deviceHeight * 0.23,
                                            decoration: BoxDecoration(
                                              color: AppColors.planeColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: homecontroller
                                                        .currentAppointment ==
                                                    null
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: deviceHeight *
                                                                0.01),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth *
                                                                      0.25,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      homecontroller
                                                                          .currentAppointment!
                                                                          .product
                                                                          .name,
                                                                      maxLines:
                                                                          2,
                                                                      style: AppFonts
                                                                          .poppinsLightMediumsnackBar
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppFonts.smallFontSize,
                                                                      )),
                                                                  Text(
                                                                      homecontroller
                                                                          .currentAppointment!
                                                                          .product
                                                                          .plan,
                                                                      style: AppFonts
                                                                          .poppinsMedium
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppFonts.smallFontSize,
                                                                        color: AppColors
                                                                            .primaryColor
                                                                            .withOpacity(0.9),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth *
                                                                      0.1,
                                                            ),
                                                            Column(
                                                              children: [
                                                                CircularPercentIndicator(
                                                                  radius: 35,
                                                                  percent: homecontroller
                                                                              .remainingdays ==
                                                                          '0'
                                                                      ? 1.0
                                                                      : 1.0 /
                                                                          int.parse(
                                                                              homecontroller.remainingdays),
                                                                  animation:
                                                                      true,
                                                                  progressColor:
                                                                      AppColors
                                                                          .appointmentscolor,
                                                                  center:
                                                                      Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        homecontroller
                                                                            .remainingdays,
                                                                        style: AppFonts
                                                                            .poppinsBold
                                                                            .copyWith(fontSize: AppFonts.mediumFontSize),
                                                                      ),
                                                                      Text(
                                                                        'Days left',
                                                                        style: AppFonts
                                                                            .poppinsRegular
                                                                            .copyWith(fontSize: 10),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth *
                                                                      0.1,
                                                            ),
                                                            Builder(builder:
                                                                (context) {
                                                              final totalPickupDays =
                                                                  homecontroller
                                                                      .currentAppointment!
                                                                      .pickups
                                                                      .length;
                                                              int remainingPickupDays =
                                                                  countPickupDatesAfterCurrentDate(
                                                                      homecontroller
                                                                          .currentAppointment!
                                                                          .pickups);
                                                              double percent =
                                                                  ((totalPickupDays -
                                                                              remainingPickupDays) /
                                                                          totalPickupDays) *
                                                                      100;

                                                              return Column(
                                                                children: [
                                                                  CircularPercentIndicator(
                                                                    radius: 35,
                                                                    percent:
                                                                        percent /
                                                                            100,
                                                                    animation:
                                                                        true,
                                                                    progressColor:
                                                                        AppColors
                                                                            .appointmentscolor,
                                                                    center:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          remainingPickupDays
                                                                              .toString(),
                                                                          style: AppFonts
                                                                              .poppinsBold
                                                                              .copyWith(fontSize: AppFonts.mediumFontSize),
                                                                        ),
                                                                        Text(
                                                                          'Pickups left',
                                                                          style: AppFonts
                                                                              .poppinsRegular
                                                                              .copyWith(fontSize: 8),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            })
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            deviceHeight * 0.01,
                                                      ),
                                                      Text('Pickup Dates',
                                                          style: AppFonts
                                                              .poppinsMedium
                                                              .copyWith()),
                                                      SizedBox(
                                                        height:
                                                            deviceHeight * 0.01,
                                                      ),
                                                      SizedBox(
                                                        height: deviceHeight *
                                                            0.065,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                homecontroller
                                                                    .currentAppointment!
                                                                    .pickups
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final month = homecontroller
                                                                  .dateConverter
                                                                  .getMonthFromDate(homecontroller
                                                                      .currentAppointment!
                                                                      .pickups[
                                                                          index]
                                                                      .pickupDate);
                                                              final date = homecontroller
                                                                  .dateConverter
                                                                  .getDayFromDate(homecontroller
                                                                      .currentAppointment!
                                                                      .pickups[
                                                                          index]
                                                                      .pickupDate);

                                                              return Container(
                                                                margin: EdgeInsets.only(
                                                                    left:
                                                                        deviceWidth *
                                                                            0.02,
                                                                    right:
                                                                        deviceWidth *
                                                                            0.02,
                                                                    bottom:
                                                                        deviceWidth *
                                                                            0.0),
                                                                width:
                                                                    deviceWidth *
                                                                        0.14,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(
                                                                                10)),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.appointmentscolor,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(month,
                                                                        style: AppFonts
                                                                            .poppinsLightMediumsnackBar
                                                                            .copyWith(
                                                                          fontSize:
                                                                              AppFonts.smallFontSize,
                                                                        )),
                                                                    Text(
                                                                      date.toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: AppFonts
                                                                          .poppinsBold
                                                                          .copyWith(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ))
                                  ]),
                                ),
                          SizedBox(
                            height: deviceHeight * 0.015,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: deviceWidth * 0.03,
                              right: deviceWidth * 0.04,
                            ),
                            height: deviceHeight * 0.03,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Text(
                                      ' Current Services',
                                      style: AppFonts.poppinsMedium.copyWith(
                                        fontSize: AppFonts.mediumFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.87,
                          crossAxisCount: 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: deviceWidth * 0.03,
                                right: deviceWidth * 0.03,
                                top: deviceHeight * 0.02,
                                bottom: deviceHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  controller.isdatepicked = false;
                                  controller.ispriceChange = false;
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
                                    builder: (context) => ProductDetail(
                                      image: images[index],
                                      id: productsdatas[index].id,
                                      price: productsdatas[index].price,
                                      name: productsdatas[index].name,
                                      plan: productsdatas[index].plan,
                                      email: homecontroller.email,
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  elevation: 0.5,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Image.asset(
                                              images[index],
                                            ),
                                            Positioned(
                                              top: 3,
                                              left: 6,
                                              child: Container(
                                                height: 35,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 0.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '\$${productsdatas[index].price.toString()}',
                                                  style: AppFonts.poppinsMedium
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: deviceHeight * 0.02,
                                            top: deviceHeight * 0.02,
                                            right: deviceHeight * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.planeColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      productsdatas[index].name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppFonts
                                                          .poppinsLightMediumsnackBar
                                                          .copyWith(
                                                        fontSize: AppFonts
                                                            .smallFontSize,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    productsdatas[index].plan,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppFonts
                                                        .poppinsMedium
                                                        .copyWith(
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: AppColors
                                                          .primaryColor
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: productsdatas.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          });
    });
  }
}
