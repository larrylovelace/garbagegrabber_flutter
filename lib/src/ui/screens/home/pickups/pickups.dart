import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/pickups/pickups_controller.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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

  void onDaySelected(DateTime day, DateTime focusedDay) {
    if (isSelectable(day)) {
      setState(() {
        today = day;
      });
    }
  }

  bool isSelectable(DateTime day) {
    final weekday = day.weekday;
    return weekday == DateTime.monday ||
        weekday == DateTime.wednesday ||
        weekday == DateTime.friday;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight > 1000 ? 100 : 50,
          title: Row(
            children: [
              Text(
                'Pickups',
                style: AppFonts.poppinsBold.copyWith(
                    fontSize: AppFonts.largeFontSize,
                    color: AppColors.kBlackColor),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
        ),
        body: GetBuilder<PickupPageController>(
          builder: (pickupscontroller) {
            return NestedScrollView(
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
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.only(
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
                          child: CircularProgressIndicator(
                              color: AppColors.kPrimaryColor),
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

                                    final totalremainingdays = pickupscontroller
                                        .dateConverter
                                        .remainingdays(enddate);

                                    double percent = totalremainingdays == 0 ||
                                            totalremainingdays < 0
                                        ? 1
                                        : 1 / totalremainingdays;
                                    final data = pickupscontroller
                                        .appointmentData
                                        .activeAppointments[index];
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
                                                .upcomingPickup!.pickupDate,

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

                                                  // Set default green color for Monday, Wednesday, and Friday
                                                  shape: BoxShape.circle,
                                                  color:
                                                      AppColors.kPrimaryColor),
                                              weekendTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      fontSize: AppFonts
                                                          .smallFontSize),
                                              selectedTextStyle: AppFonts
                                                  .poppinsRegular
                                                  .copyWith(
                                                      color: AppColors
                                                          .kBackgroundColor),
                                              disabledTextStyle:
                                                  AppFonts.poppinsRegular,
                                              outsideTextStyle:
                                                  AppFonts.poppinsRegular,
                                              withinRangeTextStyle:
                                                  AppFonts.poppinsRegular,
                                              defaultTextStyle:
                                                  AppFonts.poppinsRegular,
                                              todayTextStyle:
                                                  AppFonts.poppinsRegular,
                                              weekNumberTextStyle:
                                                  AppFonts.poppinsRegular,
                                              holidayTextStyle:
                                                  AppFonts.poppinsRegular,
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
                                            onDaySelected: onDaySelected,
                                          ),
                                        ),
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
