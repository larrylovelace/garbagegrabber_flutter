import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:garbage_grabber/utils/colors.dart';

import 'package:garbage_grabber/utils/fonts.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../controllers/apihandler.dart';
import '../../controllers/routes.dart';
import '../../controllers/token_manager.dart';

import 'package:http/http.dart ' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();

  List<String> images = [
    'assets/Onebag.png',
    'assets/Twobag.png',
    'assets/Onebag.png',
    'assets/Twobag.png',
  ];
  var productDatas = [];

  Future<void> getProductdetails() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.productdetails;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          productDatas = data['products'];
          print(productDatas);
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      } else {
        // Access token is expired or could not be obtained, handle accordingly
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getProductdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/menu.svg',
              )),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: deviceWidth * 0.02),
              child: IconButton(
                  splashRadius: 20,
                  onPressed: () {},
                  icon: Image.asset('assets/notification.png',
                      height: deviceHeight * 0.028,
                      width: deviceWidth * 0.2,
                      color: AppColors.planeColor)),
            ),
          ]),
      body: Column(
        children: <Widget>[
          HeaderwithSearch(
              deviceWidth: deviceWidth, deviceHeight: deviceHeight),
          Container(
            padding: EdgeInsets.only(
                left: deviceWidth * 0.04, right: deviceWidth * 0.04),
            height: deviceHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Text(
                      'Services',
                      style: AppFonts.poppinsMedium
                          .copyWith(fontSize: AppFonts.mediumFontSize),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: deviceHeight * 0.002,
                          color: AppColors.primaryColor.withOpacity(0.2)),
                    )
                  ],
                ),
                MaterialButton(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text('More',
                        style: AppFonts.poppinsMedium.copyWith(
                            fontSize: AppFonts.mediumFontSize,
                            color: AppColors.planeColor)))
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: productDatas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(
                      left: deviceWidth * 0.02,
                      right: deviceWidth * 0.02,
                      top: deviceHeight * 0.02,
                      bottom: deviceHeight * 0.02),
                  child: Column(
                    children: [
                      Image.asset(images[index]),
                      Container(
                        padding: EdgeInsets.only(
                            left: deviceHeight * 0.02,
                            top: deviceHeight * 0.04,
                            right: deviceHeight * 0.02),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  blurRadius: 50,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.23))
                            ]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    productDatas[index]['name'],
                                    style: AppFonts.poppinsMedium
                                        .copyWith(fontSize: 13),
                                  ),
                                ),
                                // Text(
                                //   // ignore: prefer_interpolation_to_compose_strings
                                //   '\$' +
                                //       productDatas[index]['price'].toString(),
                                //   style: AppFonts.poppinsMedium.copyWith(
                                //       color: AppColors.primaryColor,
                                //       fontSize: 12),
                                // )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  productDatas[index]['plan'],
                                  style: AppFonts.poppinsRegular.copyWith(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.9)),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class HeaderwithSearch extends StatelessWidget {
  const HeaderwithSearch({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);

    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.15,
      margin: EdgeInsets.only(bottom: deviceHeight * 0.03),
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.04,
              right: deviceWidth * 0.04,
              bottom: deviceWidth * 0.1),
          height: deviceHeight * 0.12,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hi Larry!',
                    style: AppFonts.poppinsBold.copyWith(
                        fontSize: AppFonts.largeFontSize,
                        color: AppColors.planeColor),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    formattedDate,
                    style: AppFonts.poppinsRegular
                        .copyWith(color: AppColors.planeColor),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
              height: deviceHeight * 0.054,
              decoration: BoxDecoration(
                  color: AppColors.planeColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: AppColors.primaryColor.withOpacity(0.23),
                    )
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: AppFonts.poppinsRegular.copyWith(
                          color: AppColors.primaryColor.withOpacity(0.7)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    )),
                  ),
                  SvgPicture.asset('assets/search.svg')
                ],
              ),
            ))
      ]),
    );
  }
}
