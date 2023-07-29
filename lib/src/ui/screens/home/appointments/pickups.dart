import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/Getx%20controller/pickups.dart';

import 'package:garbage_grabber/src/data/controllers/datetimehandler.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/percent_indicator.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/fonts.dart';

class PickUpsShcedule extends StatefulWidget {
  const PickUpsShcedule({super.key});

  @override
  State<PickUpsShcedule> createState() => _PickUpsShceduleState();
}

class _PickUpsShceduleState extends State<PickUpsShcedule>
    with SingleTickerProviderStateMixin {
  final PickupPageController pickupscontroller =
      Get.find<PickupPageController>();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Appointments',
                style: AppFonts.poppinsMedium
                    .copyWith(fontSize: 22, color: AppColors.planeColor),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: GetBuilder<PickupPageController>(
          builder: (pickupscontroller) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: AppColors.primaryColor,
                    pinned: true,
                    floating: true,
                    snap: true,
                    toolbarHeight: deviceHeight * 0.05,
                    bottom: TabBar(
                      controller: _tabController,
                      labelStyle: AppFonts.poppinsMedium
                          .copyWith(fontSize: AppFonts.mediumFontSize),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.planeColor,
                      indicatorWeight: 4,
                      indicatorPadding:
                          EdgeInsets.only(left: deviceWidth * 0.04),
                      tabs: const [
                        Tab(
                          text: 'Active',
                        ),
                        Tab(text: 'Past'),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  pickupscontroller
                              .appointmentData.activeAppointments.isEmpty &&
                          pickupscontroller.appointmentsisempty == false
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : pickupscontroller
                                  .appointmentData.activeAppointments.isEmpty &&
                              pickupscontroller.appointmentsisempty == true
                          ? Center(
                              child: Text(
                                'No active appointments found',
                                style: AppFonts.poppinsRegular,
                              ),
                            )
                          : CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      String startdate = pickupscontroller
                                          .appointmentData
                                          .activeAppointments[index]
                                          .appointmentDateStart;
                                      String enddate = pickupscontroller
                                          .appointmentData
                                          .activeAppointments[index]
                                          .appointmentDateEnd;
                                      int differenceInPickupDays =
                                          pickupscontroller
                                              .dateConverter
                                              .differencepickupdays(
                                                  startdate, enddate);
                                      List<Map<String, dynamic>> dates =
                                          DateGenerator.getDates(
                                              startdate, enddate);

                                      final initaldate = pickupscontroller
                                          .dateConverter
                                          .getMonthFromDate(startdate);
                                      final endingdate = pickupscontroller
                                          .dateConverter
                                          .getMonthFromDate(enddate);
                                      final initalday = pickupscontroller
                                          .dateConverter
                                          .getDayFromDate(startdate);
                                      final endingday = pickupscontroller
                                          .dateConverter
                                          .getDayFromDate(enddate);

                                      final totalremainingdays =
                                          pickupscontroller.dateConverter
                                              .remainingdays(enddate);
                                      int currentSelectedDate = 8;
                                      double percent = totalremainingdays == 0
                                          ? 1
                                          : 1 / totalremainingdays;

                                      // Current date (example: 8th date)
                                      // int numberOfDates = 7; // Total number of dates

                                      // double progress = currentSelectedDate / numberOfDates;

                                      // DateTime currentDate = DateTime.now();
                                      // Duration totalDuration = endDate.difference(startDate);

                                      // Duration elapsedDuration =
                                      //     currentDate.difference(startDate);

                                      // double percent = elapsedDuration.inMilliseconds /
                                      //     totalDuration.inMilliseconds;

                                      // ...
                                      // Build the active payments list item
                                      return Card(
                                          elevation: 1,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          margin: EdgeInsets.only(
                                              left: deviceWidth * 0.03,
                                              right: deviceWidth * 0.03,
                                              top: deviceHeight * 0.02,
                                              bottom: deviceHeight * 0.02),
                                          child: ListTile(
                                              contentPadding: EdgeInsets.only(
                                                left: deviceWidth * 0.05,
                                                top: deviceHeight * 0.02,
                                              ),
                                              onTap: () {},
                                              title: Column(
                                                children: [
                                                  totalremainingdays == 0
                                                      ? Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  deviceWidth *
                                                                      0.03),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'Appointments will be completed today',
                                                                      maxLines:
                                                                          3,
                                                                      style: AppFonts
                                                                          .poppinsMedium
                                                                          .copyWith(
                                                                              fontSize: 10)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  SizedBox(
                                                    height: deviceHeight * 0.24,
                                                    child: Row(children: [
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.1,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  deviceHeight *
                                                                      0.02,
                                                            ),
                                                            Text(initaldate,
                                                                style: AppFonts
                                                                    .poppinsLightMediumsnackBar
                                                                    .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                )),
                                                            Text(
                                                              initalday
                                                                  .toString(),
                                                              style: AppFonts
                                                                  .poppinsMedium
                                                                  .copyWith(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.05,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.25,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                pickupscontroller
                                                                    .appointmentData
                                                                    .activeAppointments[
                                                                        index]
                                                                    .product
                                                                    .name,
                                                                style: AppFonts
                                                                    .poppinsLightMediumsnackBar
                                                                    .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                )),
                                                            Text(
                                                                pickupscontroller
                                                                    .appointmentData
                                                                    .activeAppointments[
                                                                        index]
                                                                    .product
                                                                    .plan,
                                                                style: AppFonts
                                                                    .poppinsMedium
                                                                    .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: AppColors
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.9),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.05,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.28,
                                                        height:
                                                            deviceHeight * 0.2,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircularPercentIndicator(
                                                              animation: true,
                                                              percent: percent,
                                                              radius: 38,
                                                              progressColor:
                                                                  AppColors
                                                                      .appointmentscolor,
                                                              center:
                                                                  totalremainingdays ==
                                                                          0
                                                                      ? Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.check,
                                                                              color: AppColors.appointmentscolor,
                                                                              size: 30,
                                                                            )
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              totalremainingdays.toString(),
                                                                              style: AppFonts.poppinsMedium.copyWith(),
                                                                            ),
                                                                            Text(
                                                                              ' Days left',
                                                                              style: AppFonts.poppinsRegular.copyWith(fontSize: 10),
                                                                            )
                                                                          ],
                                                                        ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceWidth * 0.1,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(endingdate,
                                                                style: AppFonts
                                                                    .poppinsLightMediumsnackBar
                                                                    .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                )),
                                                            Text(
                                                              endingday
                                                                  .toString(),
                                                              style: AppFonts
                                                                  .poppinsMedium
                                                                  .copyWith(),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.only(
                                                    left: deviceWidth * 0.03),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Pickup Dates',
                                                            style: AppFonts
                                                                .poppinsMedium),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          deviceHeight * 0.02,
                                                    ),
                                                    LinearPercentIndicator(
                                                        padding: EdgeInsets.only(
                                                            left:
                                                                deviceWidth * 0,
                                                            right: deviceWidth *
                                                                0.07),
                                                        barRadius: const Radius
                                                            .circular(15),
                                                        progressColor: AppColors
                                                            .appointmentscolor,
                                                        percent:
                                                            totalremainingdays ==
                                                                    0
                                                                ? 1
                                                                : 1 /
                                                                    totalremainingdays),
                                                    SizedBox(
                                                      height:
                                                          deviceHeight * 0.02,
                                                    ),
                                                    SizedBox(
                                                      width: deviceWidth * 0.79,
                                                      child:
                                                          SingleChildScrollView(
                                                        padding: EdgeInsets.only(
                                                            right: deviceWidth *
                                                                0.03),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children:
                                                              List.generate(
                                                                  dates.length,
                                                                  (index) {
                                                            bool isCurrentDate =
                                                                (index +
                                                                        initalday) ==
                                                                    currentSelectedDate;
                                                            return Container(
                                                              width:
                                                                  deviceWidth *
                                                                      0.14,
                                                              height:
                                                                  deviceHeight *
                                                                      0.14,
                                                              margin: EdgeInsets.only(
                                                                  left:
                                                                      deviceWidth *
                                                                          0.0,
                                                                  right:
                                                                      deviceWidth *
                                                                          0.03,
                                                                  bottom:
                                                                      deviceHeight *
                                                                          0.02),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .planeColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                border:
                                                                    Border.all(
                                                                  color: AppColors
                                                                      .appointmentscolor,
                                                                  width: 1,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      dates[index]
                                                                          [
                                                                          'month'],
                                                                      style: AppFonts
                                                                          .poppinsLightMediumsnackBar
                                                                          .copyWith(
                                                                        fontSize:
                                                                            AppFonts.smallFontSize,
                                                                      )),
                                                                  Text(
                                                                    dates[index]
                                                                            [
                                                                            'day']
                                                                        .toString(),
                                                                    maxLines:
                                                                        dates.length >
                                                                                1
                                                                            ? 3
                                                                            : 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: AppFonts
                                                                        .poppinsRegular
                                                                        .copyWith(
                                                                      color: isCurrentDate
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )));
                                    },
                                    childCount: pickupscontroller
                                        .appointmentData
                                        .activeAppointments
                                        .length,
                                  ),
                                ),
                              ],
                            ),
                  pickupscontroller.appointmentData.inactiveAppointments.isEmpty
                      ? Center(
                          child: Text(
                            "No previous appointments found",
                            style: AppFonts.poppinsRegular,
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  // Build the inactive payments list item
                                  return ListTile(
                                    title: Text(
                                        'Inactive Payment ${pickupscontroller.appointmentData.inactiveAppointments[index].id}'),
                                  );
                                },
                                childCount: pickupscontroller.appointmentData
                                    .inactiveAppointments.length,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ));
  }
}
