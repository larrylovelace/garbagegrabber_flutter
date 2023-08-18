import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_grabber/src/ui/screens/home/home%20screen/product_detail.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../data/controllers/home/home screen/homescreen.dart';
import '../../../../data/controllers/home/home screen/homescreen_controller.dart';

import '../../../../data/models/products.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final HomePageController homecontroller = Get.find<HomePageController>();

  List<String> images = [
    'assets/garbagebag_onetime.png',
    'assets/garbagebag_weekly.png',
    'assets/garbagebag_monthly.png',
    'assets/garbagebag_onetime.png',
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

    return GetBuilder<HomePageController>(builder: (homecontroller) {
      return ValueListenableBuilder<Box<dynamic>>(
          valueListenable: Hive.box('homedata').listenable(),
          builder: (context, box, _) {
            if (box.isEmpty) {
              return Scaffold(
                backgroundColor: AppColors.kBackgroundColor,
                body: Center(
                  child: CircularProgressIndicator(
                      color: AppColors.kBackgroundColor),
                ),
              );
            } else {
              final products = box.get('homedata') as Products;
              String firstname = products.firstname;

              final productsdatas = products.productDatas;

              return Scaffold(
                backgroundColor: AppColors.kBackgroundColor,
                appBar: AppBar(
                  toolbarHeight: deviceHeight > 1000 ? 100 : 50,
                  backgroundColor: AppColors.kBackgroundColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: deviceHeight > 1000
                        ? EdgeInsets.only(left: deviceWidth * 0.03)
                        : EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          'Hi $firstname',
                          style: AppFonts.poppinsBold.copyWith(
                              fontSize: AppFonts.largeFontSize,
                              color: AppColors.kBlackColor),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.02,
                        ),
                        Icon(
                          Icons.waving_hand_outlined,
                          color: AppColors.kHighlightColor,
                          size: AppFonts.largeFontSize,
                        )
                      ],
                    ),
                  ),
                  // actions: [
                  //   IconButton(
                  //       splashRadius: 20,
                  //       onPressed: () {},
                  //       icon: Image.asset('assets/notification.png',
                  //           height: deviceHeight * 0.028,
                  //           width: deviceWidth * 0.2,
                  //           color: AppColors.kBlackColor)),
                  // ]
                ),
                body: RefreshIndicator(
                  color: AppColors.kPrimaryColor,
                  onRefresh: () {
                    return homecontroller.getHomeScreeData(context);
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          homecontroller.currentAppointment == null
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.03,
                                    vertical: deviceHeight * 0.01,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.02,
                                    vertical: deviceHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            blurStyle: BlurStyle.solid,
                                            color: AppColors.kBlackColor
                                                .withOpacity(0.1),
                                            offset: const Offset(0, 1))
                                      ],
                                      color: AppColors.kWhiteColor),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Trash Ready ?',
                                              style: AppFonts.poppinsMedium
                                                  .copyWith(
                                                fontSize:
                                                    AppFonts.mediumFontSize,
                                              )),
                                          SizedBox(
                                            height: deviceHeight * 0.005,
                                          ),
                                          Text(
                                              'Schedule Pickup, Leave the Rest to Us!',
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFonts.poppinsRegular
                                                  .copyWith(
                                                      fontSize: AppFonts
                                                          .minimalText)),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        'assets/pickups.svg',
                                        height: deviceHeight > 1000
                                            ? deviceHeight * 0.15
                                            : deviceHeight * 0.1,
                                      )
                                    ],
                                  ))
                              : Column(children: [
                                  Container(
                                    height: deviceHeight > 1000
                                        ? deviceHeight * 0.32
                                        : deviceHeight * 0.26,
                                    padding: EdgeInsets.only(
                                      left: deviceWidth * 0.04,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.kBackgroundColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: deviceHeight * 0.005,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: deviceWidth * 0.0,
                                              right: deviceWidth * 0.03,
                                            ),
                                            padding: EdgeInsets.only(
                                                left: deviceWidth * 0.01,
                                                top: deviceWidth * 0.02,
                                                bottom: deviceWidth * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.kBlackColor),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: deviceWidth * 0.02,
                                                  right: deviceWidth * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Upcoming Pickup',
                                                              style: AppFonts
                                                                  .poppinsMedium
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .kWhiteColor,
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize)),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  homecontroller
                                                                      .currentAppointment!
                                                                      .product
                                                                      .name,
                                                                  maxLines: 2,
                                                                  style: AppFonts
                                                                      .poppinsRegular
                                                                      .copyWith(
                                                                          fontSize: AppFonts
                                                                              .minimalText,
                                                                          color:
                                                                              AppColors.kWhiteColor)),
                                                              SizedBox(
                                                                width:
                                                                    deviceWidth *
                                                                        0.02,
                                                              ),
                                                              Text(
                                                                  "(${homecontroller.currentAppointment!.product.plan})",
                                                                  style: AppFonts
                                                                      .poppinsMedium
                                                                      .copyWith(
                                                                          fontSize: AppFonts
                                                                              .smallFontSize,
                                                                          color:
                                                                              AppColors.kWhiteColor)),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    width: deviceWidth * 0.1,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Image.asset(
                                                        'assets/calendar.png',
                                                        height:
                                                            deviceHeight > 1000
                                                                ? deviceHeight *
                                                                    0.12
                                                                : deviceHeight *
                                                                    0.09,
                                                      ),
                                                      int.parse(homecontroller
                                                                  .remainingdays) ==
                                                              0
                                                          ? Positioned(
                                                              top: deviceHeight > 1000
                                                                  ? deviceHeight *
                                                                      0.06
                                                                  : deviceHeight *
                                                                      0.049,
                                                              left: deviceHeight >
                                                                      1000
                                                                  ? deviceHeight *
                                                                      0.022
                                                                  : deviceHeight *
                                                                      0.018,
                                                              child: Row(
                                                                children: [
                                                                  Text('Today',
                                                                      style: AppFonts
                                                                          .poppinsMedium
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppFonts.smallFontSize,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                      )),
                                                                ],
                                                              ),
                                                            )
                                                          : Positioned(
                                                              top: deviceHeight >
                                                                      1000
                                                                  ? deviceHeight *
                                                                      0.044
                                                                  : deviceHeight *
                                                                      0.034,
                                                              left: deviceHeight >
                                                                      1000
                                                                  ? deviceHeight *
                                                                      0.027
                                                                  : deviceHeight *
                                                                      0.022,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          homecontroller
                                                                              .remainingdays,
                                                                          style: AppFonts
                                                                              .poppinsBold
                                                                              .copyWith(
                                                                            fontSize:
                                                                                AppFonts.mediumFontSize,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          int.parse(homecontroller.remainingdays) > 1
                                                                              ? 'Days left'
                                                                              : 'Day left',
                                                                          style: AppFonts
                                                                              .poppinsRegular
                                                                              .copyWith(
                                                                            fontSize:
                                                                                AppFonts.innerboxTextSize,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                          )),
                                                                    ],
                                                                  )
                                                                ],
                                                              ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceHeight * 0.015,
                                        ),
                                        Text('Pickup Dates',
                                            style: AppFonts.poppinsMedium
                                                .copyWith(
                                                    fontSize:
                                                        AppFonts.mediumtext,
                                                    color:
                                                        AppColors.kBlackColor)),
                                        SizedBox(
                                          height: deviceHeight * 0.01,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: homecontroller
                                                  .currentAppointment!
                                                  .pickups
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final month = homecontroller
                                                    .dateConverter
                                                    .getMonthFromDate(
                                                        homecontroller
                                                            .currentAppointment!
                                                            .pickups[index]
                                                            .pickupDate);

                                                final date = homecontroller
                                                    .dateConverter
                                                    .getDayFromDate(
                                                        homecontroller
                                                            .currentAppointment!
                                                            .pickups[index]
                                                            .pickupDate)
                                                    .toString();

                                                final upcomingPickupDate =
                                                    homecontroller.pickupdate
                                                        .toString();
                                                final upComingPickupMonth =
                                                    homecontroller.pickupmonth
                                                        .toString();

                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      left: deviceWidth * 0.0,
                                                      right: deviceWidth * 0.02,
                                                      bottom:
                                                          deviceWidth * 0.02),
                                                  width: deviceWidth * 0.14,
                                                  decoration: BoxDecoration(
                                                    color: upcomingPickupDate ==
                                                                date &&
                                                            upComingPickupMonth ==
                                                                month
                                                        ? AppColors
                                                            .kPrimaryColor
                                                        : AppColors
                                                            .kBackgroundColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(month,
                                                          style: AppFonts.poppinsLightMediumsnackBar.copyWith(
                                                              fontSize: AppFonts
                                                                  .minimalText,
                                                              color: upcomingPickupDate == date &&
                                                                      upComingPickupMonth ==
                                                                          month
                                                                  ? AppColors
                                                                      .kWhiteColor
                                                                  : AppColors
                                                                      .kBlackColor)),
                                                      Text(
                                                        date.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppFonts.poppinsBold.copyWith(
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: upcomingPickupDate ==
                                                                        date &&
                                                                    upComingPickupMonth ==
                                                                        month
                                                                ? AppColors
                                                                    .kWhiteColor
                                                                : AppColors
                                                                    .kBlackColor),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.03,
                                right: deviceWidth * 0.04,
                                bottom: deviceHeight * 0.005),
                            child: Row(
                              children: [
                                Text(
                                  ' Our Services',
                                  style: AppFonts.poppinsMedium.copyWith(
                                      color: AppColors.kBlackColor,
                                      fontSize: AppFonts.mediumtext,
                                      letterSpacing: 0.5),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: deviceHeight > 1000 ? 0.87 : 0.8,
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.isdatepicked = false;
                                controller.ispriceChange = false;
                                showModalBottomSheet(
                                  backgroundColor: AppColors.kBackgroundColor,
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
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.03,
                                    vertical: deviceHeight * 0.009),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          blurStyle: BlurStyle.solid,
                                          color: AppColors.kBlackColor
                                              .withOpacity(0.1),
                                          offset: const Offset(0, 1))
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.kWhiteColor),
                                padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.015,
                                  horizontal: deviceWidth * 0.025,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            productsdatas[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.poppinsRegular
                                                .copyWith(
                                                    fontSize:
                                                        AppFonts.minimalText),
                                          ),
                                        ),
                                        Text(
                                          '\$${productsdatas[index].price.toString()}',
                                          style:
                                              AppFonts.poppinsMedium.copyWith(
                                            color: AppColors.kHighlightColor,
                                            fontSize: AppFonts.smallFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          productsdatas[index].plan,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              AppFonts.poppinsMedium.copyWith(
                                            fontSize: AppFonts.smallFontSize,
                                            color: AppColors.kPrimaryColor
                                                .withOpacity(0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      images[index],
                                    ),
                                  ],
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
