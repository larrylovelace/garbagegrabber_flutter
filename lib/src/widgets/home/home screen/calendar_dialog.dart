import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/home%20screen/homescreen_controller.dart';
import 'package:garbage_grabber/src/widgets/global/custom_button.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({super.key});

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  HomeScreenController controller = Get.put(HomeScreenController());
  bool isSelected = false;
  final CalendarFormat _format = CalendarFormat.month;
  DateTime today = DateTime.now();
  String? formattedDate;
  void onDaySelected(DateTime day, DateTime focusedDay) {
    if (isSelectable(day)) {
      setState(() {
        today = day;
        formattedDate = formatToMonthDayYear(today);
        isSelected = true;
      });
    }
  }

  String formatToMonthDayYear(DateTime dateTime) {
    final formatter = DateFormat('EEEE , MMM-dd-yyyy');
    return formatter.format(dateTime);
  }

  bool isSelectable(DateTime day) {
    final weekday = day.weekday;
    return weekday == DateTime.monday ||
        weekday == DateTime.wednesday ||
        weekday == DateTime.friday;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
                titleCentered: false,
                titleTextStyle: AppFonts.poppinsMedium
                    .copyWith(fontSize: AppFonts.mediumFontSize)),
            rowHeight: deviceHeight * 0.07,
            calendarFormat: _format,
            weekendDays: const [
              DateTime.monday,
              DateTime.wednesday,
              DateTime.friday
            ],
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                  // Set default green color for Monday, Wednesday, and Friday
                  shape: BoxShape.circle,
                  color: AppColors.kPrimaryColor),
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.iconColor),
              weekendTextStyle: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smallFontSize),
              selectedTextStyle: AppFonts.poppinsRegular
                  .copyWith(color: AppColors.kBackgroundColor),
              disabledTextStyle: AppFonts.poppinsRegular,
              outsideTextStyle: AppFonts.poppinsRegular,
              withinRangeTextStyle: AppFonts.poppinsRegular,
              defaultTextStyle: AppFonts.poppinsRegular,
              todayTextStyle: AppFonts.poppinsRegular,
              weekNumberTextStyle: AppFonts.poppinsRegular,
              holidayTextStyle: AppFonts.poppinsRegular,
              weekendDecoration: BoxDecoration(
                  // Set default green color for Monday, Wednesday, and Friday
                  shape: BoxShape.circle,
                  color: AppColors.kPrimaryColor.withOpacity(0.2)),
            ),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: today,
            onDaySelected: onDaySelected,
            selectedDayPredicate: (day) =>
                isSelectable(day) && isSameDay(day, today),
          ),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          isSelected
              ? Column(
                  children: [
                    Text(
                      'Pickup Date',
                      style: AppFonts.poppinsMedium
                          .copyWith(fontSize: AppFonts.mediumFontSize),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    CustomButton(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth * 2,
                        text: '$formattedDate',
                        textcolor: AppColors.kBlackColor,
                        buttoncolor: AppColors.kPrimaryColor.withOpacity(0.1),
                        oncallback: () {}),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.05,
                          left: deviceWidth * 0.05,
                          right: deviceWidth * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              deviceHeight: deviceHeight,
                              deviceWidth: deviceWidth,
                              text: 'Submit',
                              textcolor: AppColors.kBackgroundColor,
                              buttoncolor: AppColors.kPrimaryColor,
                              oncallback: () {
                                if (formattedDate != null) {
                                  controller.getdate(formattedDate);
                                  Get.back();
                                }
                              }),
                          CustomButton(
                              deviceHeight: deviceHeight,
                              deviceWidth: deviceWidth,
                              text: 'Cancel',
                              textcolor: AppColors.kWhiteColor,
                              buttoncolor: AppColors.kCancelButtonColor,
                              oncallback: () {
                                Get.back();
                              })
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
