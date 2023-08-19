import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/pickups/pickups_controller.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:table_calendar/table_calendar.dart';

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
  DateTime today = DateTime.now();
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
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight > 1000 ? 100 : 50,
          title: Padding(
            padding: deviceHeight > 1000
                ? EdgeInsets.only(left: deviceWidth * 0.02)
                : EdgeInsets.zero,
            child: Row(
              children: [
                Text(
                  'Pickups',
                  style: AppFonts.poppinsBold.copyWith(
                      fontSize: AppFonts.largeFontSize,
                      color: AppColors.kBlackColor),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
        ),
        body: GetBuilder<PickupPageController>(
          builder: (pickupscontroller) {
            return NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: AppColors.kBackgroundColor,
                    pinned: false,
                    floating: false,
                    toolbarHeight: deviceHeight * 0.05,
                    bottom: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.kPrimaryColor.withOpacity(0.1),
                      ),
                      controller: _tabController,
                      labelStyle: AppFonts.poppinsMedium
                          .copyWith(fontSize: AppFonts.mediumFontSize),
                      labelColor: AppColors.kPrimaryColor,
                      unselectedLabelColor: AppColors.kCancelButtonColor,
                      splashBorderRadius: BorderRadius.circular(20),
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.04, right: deviceWidth * 0.04),
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
                          child: SizedBox(
                            width: deviceWidth * 0.07,
                            height: deviceWidth * 0.07,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.kPrimaryColor),
                          ),
                        )
                      : pickupscontroller
                                  .appointmentData.activeAppointments.isEmpty &&
                              pickupscontroller.appointmentsisempty == true
                          ? Center(
                              child: Text(
                                'No active appointments found',
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
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.03,
                                              horizontal: deviceWidth * 0.03),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    blurStyle: BlurStyle.solid,
                                                    color: AppColors.kBlackColor
                                                        .withOpacity(0.1),
                                                    offset: const Offset(0, 1))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.kWhiteColor),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: deviceWidth * 0.01,
                                              vertical: deviceHeight * 0.01),
                                          child: TableCalendar(
                                            focusedDay: pickupscontroller
                                                .upcomingPickupDate!,
                                            headerStyle: HeaderStyle(
                                                titleCentered: false,
                                                titleTextStyle: AppFonts
                                                    .poppinsMedium
                                                    .copyWith(
                                                        fontSize: AppFonts
                                                            .mediumFontSize)),
                                            rowHeight: deviceHeight * 0.14,
                                            // calendarFormat: _format,
                                            weekendDays: const [
                                              DateTime.monday,
                                              DateTime.wednesday,
                                              DateTime.friday
                                            ],
                                            calendarStyle: CalendarStyle(
                                              selectedDecoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AppColors.kPrimaryColor),
                                              weekendTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: AppColors
                                                          .kPrimaryColor),
                                              selectedTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      color: AppColors
                                                          .kWhiteColor),
                                              disabledTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      color: AppColors.iconColor
                                                          .withOpacity(
                                                        0.3,
                                                      ),
                                                      fontSize:
                                                          AppFonts.minimalText),
                                              outsideTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      color: AppColors.iconColor
                                                          .withOpacity(
                                                        0.3,
                                                      ),
                                                      fontSize:
                                                          AppFonts.minimalText),
                                              defaultTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      color: AppColors.iconColor
                                                          .withOpacity(
                                                        0.3,
                                                      ),
                                                      fontSize:
                                                          AppFonts.minimalText),
                                              weekendDecoration: BoxDecoration(
                                                  // Set default green color for Monday, Wednesday, and Friday
                                                  shape: BoxShape.circle,
                                                  color: AppColors.kPrimaryColor
                                                      .withOpacity(0.2)),
                                            ),
                                            availableCalendarFormats: const {
                                              CalendarFormat.month: 'Month'
                                            },
                                            firstDay: DateTime.parse(
                                                pickupscontroller
                                                    .appointmentData
                                                    .activeAppointments[index]
                                                    .appointmentDateStart),
                                            lastDay: DateTime.parse(
                                                pickupscontroller
                                                    .appointmentData
                                                    .activeAppointments[index]
                                                    .appointmentDateEnd),
                                            onDaySelected:
                                                (selectedDay, focusedDay) {
                                              pickupscontroller.onDaySelected(
                                                  selectedDay, focusedDay);
                                            },
                                            selectedDayPredicate: (day) =>
                                                pickupscontroller
                                                    .isSelectable(day) &&
                                                isSameDay(
                                                    day,
                                                    pickupscontroller
                                                        .upcomingPickupDate),
                                          ),
                                        ),
                                        Container(
                                          width: double.maxFinite,
                                          margin: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.03,
                                              horizontal: deviceWidth * 0.03),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    blurStyle: BlurStyle.solid,
                                                    color: AppColors.kBlackColor
                                                        .withOpacity(0.1),
                                                    offset: const Offset(0, 1))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.kWhiteColor),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: deviceWidth * 0.03,
                                              vertical: deviceHeight * 0.03),
                                          child: Column(
                                            children: [
                                              int.parse(pickupscontroller
                                                          .remainingdays
                                                          .toString()) <
                                                      0
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          'Picked',
                                                          style: AppFonts
                                                              .poppinsMedium
                                                              .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize),
                                                        ),
                                                        SizedBox(
                                                          width: deviceWidth *
                                                              0.02,
                                                        ),
                                                        CircleAvatar(
                                                          radius: deviceWidth *
                                                              0.02,
                                                          backgroundColor:
                                                              AppColors
                                                                  .kPrimaryColor,
                                                          child: Icon(
                                                            Icons.check,
                                                            size: AppFonts
                                                                .smallFontSize,
                                                            color: AppColors
                                                                .kWhiteColor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : int.parse(pickupscontroller
                                                              .remainingdays
                                                              .toString()) ==
                                                          0
                                                      ? Row(children: [
                                                          Text('Picking today',
                                                              style: AppFonts
                                                                  .poppinsMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize))
                                                        ])
                                                      : const SizedBox(),
                                              SizedBox(
                                                height: deviceHeight * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  AppointmentDateContainer(
                                                      deviceWidth: deviceWidth,
                                                      deviceHeight:
                                                          deviceHeight,
                                                      appointmentMonth:
                                                          pickupscontroller
                                                              .upComingpickupMonth!,
                                                      appointmentDate: int.parse(
                                                          pickupscontroller
                                                              .comingPickupDate!)),
                                                  SizedBox(
                                                    width: deviceWidth * 0.03,
                                                  ),
                                                  Column(
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppFonts
                                                            .poppinsRegular
                                                            .copyWith(
                                                                fontSize: AppFonts
                                                                    .minimalText),
                                                      ),
                                                      Text(
                                                        pickupscontroller
                                                            .appointmentData
                                                            .activeAppointments[
                                                                index]
                                                            .product
                                                            .plan,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppFonts
                                                            .poppinsMedium
                                                            .copyWith(
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: AppColors
                                                                    .kPrimaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                  int.parse(pickupscontroller
                                                                  .remainingdays
                                                                  .toString()) <
                                                              0 ||
                                                          int.parse(pickupscontroller
                                                                  .remainingdays
                                                                  .toString()) ==
                                                              0
                                                      ? const SizedBox()
                                                      : Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  deviceWidth *
                                                                      0.34),
                                                          child:
                                                              CircularPercentIndicator(
                                                            lineWidth:
                                                                deviceHeight >
                                                                        1000
                                                                    ? 10
                                                                    : 3,
                                                            progressColor:
                                                                AppColors
                                                                    .kPrimaryColor,
                                                            backgroundColor:
                                                                AppColors
                                                                    .kPrimaryColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            percent: pickupscontroller
                                                                        .remainingdays ==
                                                                    '0'
                                                                ? 1.0
                                                                : 1.0 / int.parse(pickupscontroller.remainingdays.toString()) ==
                                                                        1
                                                                    ? 0.95
                                                                    : 1 /
                                                                        int.parse(pickupscontroller
                                                                            .remainingdays
                                                                            .toString()),
                                                            radius:
                                                                deviceHeight *
                                                                    0.08,
                                                            center: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  pickupscontroller
                                                                      .remainingdays
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppFonts
                                                                      .poppinsBold
                                                                      .copyWith(
                                                                          fontSize: AppFonts
                                                                              .smallFontSize,
                                                                          color:
                                                                              AppColors.kPrimaryColor),
                                                                ),
                                                                Text(
                                                                  int.parse(pickupscontroller
                                                                              .remainingdays!) >
                                                                          1
                                                                      ? 'Days left'
                                                                      : 'Day left',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppFonts
                                                                      .poppinsRegular
                                                                      .copyWith(
                                                                          fontSize: AppFonts
                                                                              .innerboxTextSize,
                                                                          color:
                                                                              AppColors.kPrimaryColor),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }, childCount: 1),
                                ),
                              ],
                            ),
                  pickupscontroller.appointmentData.inactiveAppointments.isEmpty
                      ? Center(
                          child: Text(
                            "No previous appointments found",
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
                                  // Build the inactive payments list item

                                  final startDate = pickupscontroller
                                      .appointmentData
                                      .inactiveAppointments[index]
                                      .appointmentDateStart;
                                  final endDate = pickupscontroller
                                      .appointmentData
                                      .inactiveAppointments[index]
                                      .appointmentDateEnd;

                                  final appointmentStartMonth =
                                      pickupscontroller.dateConverter
                                          .getMonthFromDate(startDate);
                                  final appointmentEndMonth = pickupscontroller
                                      .dateConverter
                                      .getMonthFromDate(endDate);
                                  final appointmentStartDate = pickupscontroller
                                      .dateConverter
                                      .getDayFromDate(startDate);
                                  final appointmentEndDate = pickupscontroller
                                      .dateConverter
                                      .getDayFromDate(endDate);
                                  final pickupslength = pickupscontroller
                                      .appointmentData
                                      .inactiveAppointments[index]
                                      .pickups
                                      .length;
                                  return Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                          vertical: deviceHeight * 0.03,
                                          horizontal: deviceWidth * 0.03),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                blurStyle: BlurStyle.solid,
                                                color: AppColors.kBlackColor
                                                    .withOpacity(0.1),
                                                offset: const Offset(0, 1))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kWhiteColor),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: deviceWidth * 0.06,
                                          vertical: deviceHeight * 0.06),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Completed',
                                                style: AppFonts.poppinsMedium
                                                    .copyWith(
                                                        fontSize: AppFonts
                                                            .mediumtext),
                                              ),
                                              SizedBox(
                                                width: deviceWidth * 0.02,
                                              ),
                                              CircleAvatar(
                                                radius: deviceWidth * 0.021,
                                                backgroundColor:
                                                    AppColors.kPrimaryColor,
                                                child: Icon(
                                                  Icons.check,
                                                  size: AppFonts.smallFontSize,
                                                  color: AppColors.kWhiteColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: deviceHeight * 0.01,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    pickupscontroller
                                                        .appointmentData
                                                        .inactiveAppointments[
                                                            index]
                                                        .product
                                                        .name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppFonts
                                                        .poppinsRegular
                                                        .copyWith(
                                                            fontSize: AppFonts
                                                                .minimalText),
                                                  ),
                                                  Text(
                                                    pickupscontroller
                                                        .appointmentData
                                                        .inactiveAppointments[
                                                            index]
                                                        .product
                                                        .plan,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppFonts
                                                        .poppinsMedium
                                                        .copyWith(
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: AppColors
                                                                .kPrimaryColor),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: deviceWidth * 0.02,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        pickupslength > 1
                                                            ? ' $pickupslength Pickups'
                                                            : ' $pickupslength Pickup',
                                                        style: AppFonts
                                                            .poppinsRegular
                                                            .copyWith(
                                                                fontSize: AppFonts
                                                                    .minimalText),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '$appointmentStartMonth $appointmentStartDate - $appointmentEndMonth $appointmentEndDate',
                                                        style: AppFonts
                                                            .poppinsMedium
                                                            .copyWith(
                                                                fontSize: AppFonts
                                                                    .smallFontSize,
                                                                color: AppColors
                                                                    .kPrimaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ));
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

class AppointmentDateContainer extends StatelessWidget {
  const AppointmentDateContainer({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.appointmentMonth,
    required this.appointmentDate,
  });

  final double deviceWidth;
  final double deviceHeight;
  final String appointmentMonth;
  final int appointmentDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.03),
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appointmentMonth,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.poppinsRegular.copyWith(
                fontSize: AppFonts.smallFontSize,
                color: AppColors.kPrimaryColor),
          ),
          Text(
            appointmentDate.toString(),
            overflow: TextOverflow.ellipsis,
            style: AppFonts.poppinsBold.copyWith(
                fontSize: AppFonts.smallFontSize,
                color: AppColors.kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
