import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garbage_grabber/utils/colors.dart';

import 'package:garbage_grabber/utils/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
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
            Column(
              children: [
                Row(
                  children: [
                    CustomCard(
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      image: 'assets/Onebag.png',
                      text: '1 Standard Bag',
                      timeperiod: 'Weekly',
                      price: '2.10',
                    ),
                    CustomCard(
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      image: 'assets/Twobag.png',
                      text: '2 Standard Bag',
                      timeperiod: 'Weekly',
                      price: '4.80',
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCard(
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      image: 'assets/Onebag.png',
                      text: '1 Standard Bag',
                      timeperiod: 'Monthly',
                      price: '21.95',
                    ),
                    CustomCard(
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      image: 'assets/Twobag.png',
                      text: '2 Standard Bag',
                      timeperiod: 'Monthly',
                      price: '49.95',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.image,
    required this.text,
    required this.price,
    required this.timeperiod,
  });

  final double deviceHeight;
  final double deviceWidth;
  final String image;
  final String text;
  final String timeperiod;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: deviceWidth * 0.02,
          right: deviceWidth * 0.02,
          top: deviceHeight * 0.02,
          bottom: deviceHeight * 0.02),
      width: deviceWidth * 0.45,
      child: Column(
        children: [
          Image.asset(image),
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
                      color: AppColors.primaryColor.withOpacity(0.23))
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: AppFonts.poppinsMedium.copyWith(fontSize: 12),
                      ),
                    ),
                    Text(
                      '\$$price',
                      style: AppFonts.poppinsMedium.copyWith(
                          color: AppColors.primaryColor, fontSize: 12),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      timeperiod,
                      style: AppFonts.poppinsRegular.copyWith(
                          color: AppColors.primaryColor.withOpacity(0.9)),
                    )
                  ],
                )
              ],
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
                    'Jun - 16 - 2023',
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
