import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/controllers/home/settings/profile_details_controller.dart';
import 'package:garbage_grabber/src/widgets/global/custom_button.dart';
import 'package:garbage_grabber/src/widgets/home/settings/details_widget.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:unicons/unicons.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../widgets/home/settings/profile_edit.dart';
import '../../floatingbutton/customerqr.dart';

class ProfileDetis extends StatefulWidget {
  const ProfileDetis({super.key});

  @override
  State<ProfileDetis> createState() => _ProfileDetisState();
}

class _ProfileDetisState extends State<ProfileDetis> {
  final ProfileEditController profileEditController =
      Get.put(ProfileEditController());
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var box = Hive.box('homedata');
    var products = box.get('homedata');

    return Obx(() => Scaffold(
          backgroundColor: AppColors.secondaryColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: true,
            titleSpacing: 11,
            title: Row(
              children: [
                Text(
                  'Profile Details',
                  style: AppFonts.poppinsMedium
                      .copyWith(fontSize: 22, color: AppColors.planeColor),
                ),
              ],
            ),
            // actions: profileEditController.edit.value
            //     ? []
            //     : [
            //         IconButton(
            //             splashRadius: 20,
            //             onPressed: () {
            //               profileEditController.onEdit();
            //               profileEditController.getHiveData();
            //             },
            //             icon: Icon(
            //               LineAwesomeIcons.pen,
            //               color: AppColors.planeColor,
            //             ))
            //       ],
            elevation: 0,
          ),
          body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.only(top: deviceWidth * 0.0),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: profileEditController.edit.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.03,
                                  bottom: deviceHeight * 0.03,
                                  left: deviceWidth * 0.03,
                                  right: deviceWidth * 0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProfileEditField(
                                    controller: profileEditController.firstname,
                                    labelText: 'First Name',
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.02,
                                  ),
                                  ProfileEditField(
                                    controller: profileEditController.lastname,
                                    labelText: 'Last Name',
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.02,
                                  ),
                                  ProfileEditField(
                                    controller: profileEditController.phoneNum,
                                    labelText: 'Phone Number',
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButton(
                                          deviceHeight: deviceHeight,
                                          deviceWidth: deviceWidth,
                                          text: 'Cancel',
                                          textcolor: AppColors.planeColor,
                                          buttoncolor:
                                              AppColors.cancelButtonColor,
                                          oncallback: () {
                                            profileEditController.onEdit();
                                          }),
                                      CustomButton(
                                          deviceHeight: deviceHeight,
                                          deviceWidth: deviceWidth,
                                          text: 'Save',
                                          textcolor: AppColors.planeColor,
                                          buttoncolor: AppColors.primaryColor,
                                          oncallback: () {}),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                DetailsWidget(
                                  onpress: () {},
                                  title: products.firstname,
                                  subtitle: 'Fisrt Name',
                                  deviceWidth: deviceWidth,
                                  icon: LineAwesomeIcons.user,
                                ),
                                DetailsWidget(
                                  onpress: () {},
                                  title: products.lastname,
                                  subtitle: 'Last Name',
                                  deviceWidth: deviceWidth,
                                  icon: LineAwesomeIcons.user_1,
                                ),
                                DetailsWidget(
                                  onpress: () {},
                                  title: products.email,
                                  subtitle: 'Email',
                                  deviceWidth: deviceWidth,
                                  icon: Icons.email_outlined,
                                ),
                                DetailsWidget(
                                  onpress: () {},
                                  title: products.phonenumber,
                                  subtitle: 'Phone',
                                  icon: UniconsLine.phone,
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
                              topRight: Radius.circular(20))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: deviceHeight * 0.01,
                            ),
                            // ProfileDetails(
                            //     title: 'Change Password',
                            //     subtitle: 'Change your password',
                            //     icon: Icons.key_outlined,
                            //     onpress: () {},
                            //     deviceWidth: deviceWidth),
                            DetailsWidget(
                                title: 'QR Code',
                                subtitle: 'View your qr code',
                                icon: Icons.qr_code_scanner_outlined,
                                onpress: () {
                                  showModalBottomSheet(
                                      backgroundColor: AppColors.planeColor,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) => const QRprofile());
                                },
                                deviceWidth: deviceWidth)
                          ]),
                    )
                  ],
                ),
              ]))
            ],
          ),
        ));
  }
}
