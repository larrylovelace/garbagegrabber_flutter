import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/controllers/datetimehandler.dart';
import 'package:garbage_grabber/models/appointments.dart';

import 'package:http/http.dart ' as http;

import '../../../controllers/api_cache.dart';
import '../../../controllers/apihandler.dart';
import '../../../controllers/token_manager.dart';
import '../../../controllers/datetime.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/error_handling.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PickUpsShcedule extends StatefulWidget {
  const PickUpsShcedule({super.key});

  @override
  State<PickUpsShcedule> createState() => _PickUpsShceduleState();
}

class _PickUpsShceduleState extends State<PickUpsShcedule>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  AppointmentData appointmentData =
      AppointmentData(activeAppointments: [], inactiveAppointments: []);

  DateConverter dateConverter = DateConverter();
  DateGenerator dategenerator = DateGenerator();
  bool appointmentsisempty = false;
  Future<void> pickupschedule() async {
    const storage = FlutterSecureStorage();
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.registerappointment;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          appointmentData = AppointmentData.fromJson(data['data']);

          if (appointmentData.activeAppointments.isEmpty) {
            appointmentsisempty = true;
          }
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
    const cacheKey = 'page_1'; // Set the cache key for PickUpsShcedule
    if (ApiCache.apiCache.containsKey(cacheKey)) {
      appointmentData = ApiCache.apiCache[cacheKey];
      print('s');
    } else {
      pickupschedule();
    }

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
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Appointments',
          style:
              AppFonts.poppinsBold.copyWith(fontSize: AppFonts.largeFontSize),
        ),
      ),
      body: NestedScrollView(
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
                indicatorPadding: EdgeInsets.only(left: deviceWidth * 0.04),
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
            appointmentData.activeAppointments.isEmpty &&
                    appointmentsisempty == false
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : appointmentData.activeAppointments.isEmpty &&
                        appointmentsisempty == true
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
                                String startdate = appointmentData
                                    .activeAppointments[index]
                                    .appointmentDateStart;
                                String enddate = appointmentData
                                    .activeAppointments[index]
                                    .appointmentDateEnd;
                                int differenceInPickupDays = dateConverter
                                    .differencepickupdays(startdate, enddate);
                                List<Map<String, dynamic>> dates =
                                    DateGenerator.getDates(startdate, enddate);

                                final initaldate =
                                    dateConverter.getMonthFromDate(startdate);
                                final endingdate =
                                    dateConverter.getMonthFromDate(enddate);
                                final initalday =
                                    dateConverter.getDayFromDate(startdate);
                                final endingday =
                                    dateConverter.getDayFromDate(enddate);

                                final totalremainingdays =
                                    dateConverter.remainingdays(enddate);
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
                                                            deviceWidth * 0.03),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Appointments will be completed today',
                                                                maxLines: 3,
                                                                style: AppFonts
                                                                    .poppinsMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10)),
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
                                                  width: deviceWidth * 0.1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            deviceHeight * 0.02,
                                                      ),
                                                      Text(initaldate,
                                                          style: AppFonts
                                                              .poppinsLightMediumsnackBar
                                                              .copyWith(
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                          )),
                                                      Text(
                                                        initalday.toString(),
                                                        style: AppFonts
                                                            .poppinsMedium
                                                            .copyWith(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: deviceWidth * 0.05,
                                                ),
                                                SizedBox(
                                                  width: deviceWidth * 0.25,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          appointmentData
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
                                                          appointmentData
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
                                                  width: deviceWidth * 0.05,
                                                ),
                                                SizedBox(
                                                  width: deviceWidth * 0.28,
                                                  height: deviceHeight * 0.2,
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
                                                        progressColor: AppColors
                                                            .appointmentscolor,
                                                        center:
                                                            totalremainingdays ==
                                                                    0
                                                                ? Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: AppColors
                                                                            .appointmentscolor,
                                                                        size:
                                                                            30,
                                                                      )
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        totalremainingdays
                                                                            .toString(),
                                                                        style: AppFonts
                                                                            .poppinsMedium
                                                                            .copyWith(),
                                                                      ),
                                                                      Text(
                                                                        ' Days left',
                                                                        style: AppFonts
                                                                            .poppinsRegular
                                                                            .copyWith(fontSize: 10),
                                                                      )
                                                                    ],
                                                                  ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: deviceWidth * 0.1,
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
                                                        endingday.toString(),
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
                                                height: deviceHeight * 0.02,
                                              ),
                                              LinearPercentIndicator(
                                                  padding: EdgeInsets.only(
                                                      left: deviceWidth * 0,
                                                      right:
                                                          deviceWidth * 0.07),
                                                  barRadius:
                                                      const Radius.circular(15),
                                                  progressColor: AppColors
                                                      .appointmentscolor,
                                                  percent: totalremainingdays ==
                                                          0
                                                      ? 1
                                                      : 1 / totalremainingdays),
                                              SizedBox(
                                                height: deviceHeight * 0.02,
                                              ),
                                              SizedBox(
                                                width: deviceWidth * 0.79,
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          deviceWidth * 0.03),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: List.generate(
                                                        dates.length, (index) {
                                                      bool isCurrentDate =
                                                          (index + initalday) ==
                                                              currentSelectedDate;
                                                      return Container(
                                                        width:
                                                            deviceWidth * 0.15,
                                                        height:
                                                            deviceHeight * 0.12,
                                                        margin: EdgeInsets.only(
                                                            left: deviceWidth *
                                                                0.0,
                                                            right: deviceWidth *
                                                                0.03,
                                                            bottom:
                                                                deviceHeight *
                                                                    0.02),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isCurrentDate
                                                              ? Colors.blue
                                                              : AppColors
                                                                  .planeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: isCurrentDate
                                                                ? Colors.blue
                                                                : AppColors
                                                                    .appointmentscolor,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                dates[index]
                                                                    ['month'],
                                                                style: AppFonts
                                                                    .poppinsLightMediumsnackBar
                                                                    .copyWith(
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                )),
                                                            Text(
                                                              dates[index]
                                                                      ['day']
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
                              childCount:
                                  appointmentData.activeAppointments.length,
                            ),
                          ),
                        ],
                      ),
            appointmentData.inactiveAppointments.isEmpty
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
                                  'Inactive Payment ${appointmentData.inactiveAppointments[index].id}'),
                            );
                          },
                          childCount:
                              appointmentData.inactiveAppointments.length,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
