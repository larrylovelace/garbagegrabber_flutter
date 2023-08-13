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
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: true,
          titleSpacing: 11,
          title: Row(
            children: [
              Text(
                'Address Details',
                style: AppFonts.poppinsMedium
                    .copyWith(fontSize: 22, color: AppColors.planeColor),
              ),
            ],
          ),
        ),
        body: GetBuilder<AddressDetailsScreenController>(
          builder: (controller) {
            return addressDetailsScreenController.addressDetailsModel == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            Card(
                              elevation: 0,
                              margin: EdgeInsets.only(
                                top: deviceWidth * 0.0,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
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
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.apartmentNumber
                                        .toString(),
                                    subtitle: 'Apartment Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.unitNumber
                                        .toString(),
                                    subtitle: 'Unit Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                  DetailsWidget(
                                    leadingicon: false,
                                    onpress: () {},
                                    title: addressDetailsScreenController
                                        .addressDetailsModel!.floorNumber
                                        .toString(),
                                    subtitle: 'Floor Number',
                                    deviceWidth: deviceWidth,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 0,
                              margin: EdgeInsets.only(
                                top: deviceHeight * 0.04,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
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
                                    DetailsWidget(
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.city,
                                        subtitle: 'City',
                                        icon: LineAwesomeIcons.city,
                                        onpress: () {},
                                        deviceWidth: deviceWidth),
                                    DetailsWidget(
                                        leadingicon: true,
                                        title: addressDetailsScreenController
                                            .addressDetailsModel!.state,
                                        subtitle: 'State',
                                        icon: LineAwesomeIcons.landmark,
                                        onpress: () {},
                                        deviceWidth: deviceWidth),
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
