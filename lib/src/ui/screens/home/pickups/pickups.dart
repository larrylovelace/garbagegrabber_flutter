import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/pickups_controller.dart';

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
        backgroundColor: AppColors.secondaryColor,
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
                    pinned: false,
                    floating: false,
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

                                      double percent = totalremainingdays == 0
                                          ? 1
                                          : 1 / totalremainingdays;
                                      final data = pickupscontroller
                                          .appointmentData
                                          .activeAppointments[index];
                                      return Card(
                                          color: AppColors.planeColor,
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
                                                                            totalremainingdays>1?
                                                                            Text(
                                                                              ' Days left',
                                                                              style: AppFonts.poppinsRegular.copyWith(fontSize: 10),
                                                                            ): Text(
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
                                                    left: deviceWidth * 0.02),
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
                                                      height:
                                                          deviceHeight * 0.19,
                                                      width: deviceWidth * 0.79,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: data
                                                              .pickups.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final month = pickupscontroller
                                                                .dateConverter
                                                                .getMonthFromDate(data
                                                                    .pickups[
                                                                        index]
                                                                    .pickupDate
                                                                    .toString());

                                                            final date = pickupscontroller
                                                                .dateConverter
                                                                .getDayFromDate(data
                                                                    .pickups[
                                                                        index]
                                                                    .pickupDate
                                                                    .toString());

                                                            return Container(
                                                              margin: EdgeInsets.only(
                                                                  left:
                                                                      deviceWidth *
                                                                          0.00,
                                                                  right:
                                                                      deviceWidth *
                                                                          0.04,
                                                                  top:
                                                                      deviceWidth *
                                                                          0.02,
                                                                  bottom:
                                                                      deviceWidth *
                                                                          0.02),
                                                              width:
                                                                  deviceWidth *
                                                                      0.14,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .appointmentscolor,
                                                                        width:
                                                                            1,
                                                                      )),
                                                              child:
                                                                  MaterialButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                onPressed:
                                                                    () {},
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(month,
                                                                        style: AppFonts
                                                                            .poppinsRegular
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
                                                                          .poppinsMedium
                                                                          .copyWith(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    )
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
