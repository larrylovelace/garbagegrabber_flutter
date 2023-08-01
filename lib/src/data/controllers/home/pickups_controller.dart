import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/src/data/repositories/pickups_repo.dart';
import 'package:get/get.dart';
import '../../models/pickups_model.dart';
import '../datetime.dart';
import '../datetimehandler.dart';

class PickupPageController extends GetxController {
  final storage = const FlutterSecureStorage();
  AppointmentData appointmentData =
      AppointmentData(activeAppointments: [], inactiveAppointments: []);

  DateConverter dateConverter = DateConverter();
  DateGenerator dategenerator = DateGenerator();
  final PickupsRepository _pickupsRepository = PickupsRepository();
  bool appointmentsisempty = false;
  Future<void> pickupschedule(BuildContext context) async {
    // Add the context parameter here
    try {
      Map<String, dynamic> data = await _pickupsRepository.pickupsRepo(context);
      appointmentData = AppointmentData.fromJson(data['data']);

      if (appointmentData.activeAppointments.isEmpty) {
        appointmentsisempty = true;
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
