import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/settings/address_details_controller.dart';
import 'package:garbage_grabber/src/widgets/home/settings/details_widget.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:unicons/unicons.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/fonts.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  final AddressDetailsScreenController addressDetailsScreenController =
      Get.put(AddressDetailsScreenController());

  @override
  void initState() {
    addressDetailsScreenController.addressDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.kBlackColor),
          toolbarHeight: deviceHeight > 1000 ? 100 : 50,
          title: Row(
            children: [
              Text(
                'Address Details',
                style: AppFonts.poppinsBold.copyWith(
                    fontSize: AppFonts.largeFontSize,
                    color: AppColors.kBlackColor),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
        ),
        body: GetBuilder<AddressDetailsScreenController>(
          builder: (controller) {
            return addressDetailsScreenController.addressDetailsModel == null
                ? Center(
                    child: SizedBox(
                      width: deviceWidth * 0.07,
                      height: deviceWidth * 0.07,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.kPrimaryColor),
                    ),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            deviceHeight > 1000
                                ? SizedBox(
                                    height: deviceHeight * 0.02,
                                  )
                                : const SizedBox(),
                            Card(
                              elevation: 0,
                              color: AppColors.kBackgroundColor,
                              margin: EdgeInsets.only(
                                top: deviceWidth * 0.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DetailsWidget(
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!
                                        .apartmentComplexName,
                                    subtitle: 'Apartment Complex Name',
                                    deviceWidth: deviceWidth,
                                    icon: UniconsLine.building,
                                  ),
                                  deviceHeight > 1000
                                      ? SizedBox(
                                          height: deviceHeight * 0.02,
                                        )
                                      : const SizedBox(),
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.apartmentNumber
                                        .toString(),
                                    subtitle: 'Apartment Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                  deviceHeight > 1000
                                      ? SizedBox(
                                          height: deviceHeight * 0.02,
                                        )
                                      : const SizedBox(),
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.unitNumber
                                        .toString(),
                                    subtitle: 'Unit Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                  deviceHeight > 1000
                                      ? SizedBox(
                                          height: deviceHeight * 0.02,
                                        )
                                      : const SizedBox(),
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.floorNumber
                                        .toString(),
                                    subtitle: 'Floor Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                  deviceHeight > 1000
                                      ? SizedBox(
                                          height: deviceHeight * 0.02,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: deviceHeight * 0.04,
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.kBackgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: deviceHeight * 0.02,
                                    ),
                                    // ProfileDetails(
                                    //     title: 'Change Password',
                                    //     subtitle: 'Change your password',
                                    //     icon: Icons.key_outlined,
                                    //     onpress: () {},
                                    //     deviceWidth: deviceWidth),
                                    DetailsWidget(
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.streetAddress,
                                        subtitle: 'Street Address',
                                        icon: UniconsLine.location_pin_alt,
                                        onpress: () {},
                                        deviceWidth: deviceWidth),
                                    deviceHeight > 1000
                                        ? SizedBox(
                                            height: deviceHeight * 0.02,
                                          )
                                        : const SizedBox(),
                                    DetailsWidget(
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.city,
                                        subtitle: 'City',
                                        icon: LineAwesomeIcons.city,
                                        onpress: () {},
                                        deviceWidth: deviceWidth),
                                    deviceHeight > 1000
                                        ? SizedBox(
                                            height: deviceHeight * 0.02,
                                          )
                                        : const SizedBox(),
                                    DetailsWidget(
                                        leadingicon: true,
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.state,
                                        subtitle: 'State',
                                        icon: LineAwesomeIcons.landmark,
                                        onpress: () {},
                                        deviceWidth: deviceWidth),
                                    deviceHeight > 1000
                                        ? SizedBox(
                                            height: deviceHeight * 0.02,
                                          )
                                        : const SizedBox(),
                                    DetailsWidget(
                                        leadingicon: true,
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.zipcode
                                            .toString(),
                                        subtitle: 'Zip Code',
                                        onpress: () {},
                                        icon: Icons.my_location_outlined,
                                        deviceWidth: deviceWidth)
                                  ]),
                            )
                          ],
                        )
                      ]))
                    ],
                  );
          },
        ));
  }
}
