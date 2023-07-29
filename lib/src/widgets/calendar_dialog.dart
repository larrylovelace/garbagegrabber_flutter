import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/homescreen_controller.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';



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
    return SizedBox(
      height: deviceHeight * 0.7,
      width: double.infinity,
      child: SingleChildScrollView(
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
                    color: AppColors.primaryColor),
                todayDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.iconColor),
                weekendTextStyle: AppFonts.poppinsRegular,
                weekendDecoration: BoxDecoration(
                    // Set default green color for Monday, Wednesday, and Friday
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withOpacity(0.2)),
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
                        height: deviceHeight * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            color: AppColors.planeColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        height: deviceHeight * 0.05,
                        width: deviceWidth * 0.7,
                        child: Center(
                            child: Text(
                          '$formattedDate',
                          style: AppFonts.poppinsMedium.copyWith(
                              fontSize: AppFonts.mediumFontSize,
                              color: AppColors.primaryColor),
                        )),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: deviceHeight * 0.05,
                            width: deviceWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.primaryColor),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {
                                if (formattedDate != null) {
                                  controller.getdate(formattedDate);
                                  Get.back();
                                }
                              },
                              child: Text(
                                'Submit',
                                style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: AppFonts.mediumFontSize,
                                    color: AppColors.planeColor),
                              ),
                            ),
                          ),
                          Container(
                            height: deviceHeight * 0.05,
                            width: deviceWidth * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.secondaryColor.withOpacity(1)),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: AppFonts.mediumFontSize,
                                    color: AppColors.cancelColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
