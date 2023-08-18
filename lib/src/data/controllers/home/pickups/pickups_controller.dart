import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/repositories/pickups_repo.dart';
import 'package:get/get.dart';
import '../../../models/pickups_model.dart';
import '../../date and time/datetime.dart';
import '../../date and time/datetimehandler.dart';

class PickupPageController extends GetxController {
  AppointmentData appointmentData =
      AppointmentData(activeAppointments: [], inactiveAppointments: []);
  UpcomingPickup? upcomingPickup;

  DateConverter dateConverter = DateConverter();
  DateGenerator dategenerator = DateGenerator();
  final PickupsRepository _pickupsRepository = PickupsRepository();
  bool appointmentsisempty = false;
  DateTime? upcomingPickupDate;
  String? upComingpickupMonth;
  String? comingPickupDate;
  String? remainingdays;
  bool isSelectable(DateTime day) {
    final weekday = day.weekday;
    return weekday == DateTime.monday ||
        weekday == DateTime.wednesday ||
        weekday == DateTime.friday;
  }

  onDaySelected(DateTime day, DateTime focusedDays) {
    if (isSelectable(day)) {
      upcomingPickupDate = day;
      upComingpickupMonth =
          dateConverter.getMonthFromDate(upcomingPickupDate.toString());
      comingPickupDate = dateConverter
          .getDayFromDate(upcomingPickupDate.toString())
          .toString();

      remainingdays =
          dateConverter.remainingdays(upcomingPickupDate.toString()).toString();

      update();
    }
  }

  Future<void> pickupschedule(BuildContext context) async {
    // Add the context parameter here
    try {
      Map<String, dynamic> data = await _pickupsRepository.pickupsRepo(context);
      appointmentData = AppointmentData.fromJson(data['appointments']);

      if (appointmentData.activeAppointments.isEmpty) {
        appointmentsisempty = true;
      } else {
        upcomingPickup = UpcomingPickup.fromJson(data['upcoming_pickup']);
        upcomingPickupDate = upcomingPickup!.pickupDate;

        upComingpickupMonth =
            dateConverter.getMonthFromDate(upcomingPickupDate.toString());
        comingPickupDate = dateConverter
            .getDayFromDate(upcomingPickupDate.toString())
            .toString();

        remainingdays = dateConverter
            .remainingdays(upcomingPickupDate.toString())
            .toString();
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
