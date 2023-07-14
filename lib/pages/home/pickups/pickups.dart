import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/models/pickups.dart';

import 'package:http/http.dart ' as http;

import '../../../controllers/apihandler.dart';
import '../../../controllers/token_manager.dart';
import '../../../models/datetime.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/error_handling.dart';

class PickUpsShcedule extends StatefulWidget {
  const PickUpsShcedule({super.key});

  @override
  State<PickUpsShcedule> createState() => _PickUpsShceduleState();
}

class _PickUpsShceduleState extends State<PickUpsShcedule> {
  List<Appointment>? pickups;

  DateConverter dateConverter = DateConverter();

  Future<void> pickupschedule() async {
    const storage = FlutterSecureStorage();
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.pickups;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          List<dynamic> appointmentDataList = List<dynamic>.from(jsonData);

          List<Appointment> appointmentList = appointmentDataList
              .map((data) => Appointment.fromJson(data))
              .toList();
          pickups = appointmentList.isNotEmpty ? appointmentList : null;
          setState(() {});
        }
      } else {
        // Handle the case when accessToken is null
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    pickupschedule();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Pickups',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: 22, color: AppColors.planeColor),
            ),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.2,
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: pickups?.length ?? 0,
        itemBuilder: (context, index) {
          Appointment appointment = pickups![index];
          String dateStr = appointment.pickupDate.toString();
          String month = dateConverter.getMonthFromDate(dateStr);
          int day = dateConverter.getDayFromDate(dateStr);

          return Card(
            margin: EdgeInsets.only(
                left: deviceWidth * 0.02,
                top: deviceHeight * 0.02,
                right: deviceWidth * 0.02,
                bottom: deviceHeight * 0.02),
            child: ListTile(
              onTap: () {},
              leading: Column(
                children: [
                  Text(
                    month,
                    style: AppFonts.poppinsRegular,
                  ),
                  Text(
                    day.toString(),
                    style: AppFonts.poppinsMedium
                        .copyWith(fontSize: AppFonts.mediumFontSize),
                  )
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Picked',
                    style: AppFonts.poppinsMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        'Picked by:',
                        style: AppFonts.poppinsRegular
                            .copyWith(fontSize: AppFonts.snackBarfontsmall),
                      ),
                      Text(
                        'Larrylove Lace',
                        style: AppFonts.poppinsMedium
                            .copyWith(fontSize: AppFonts.smallFontSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
