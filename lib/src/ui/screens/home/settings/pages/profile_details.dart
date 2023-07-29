import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:unicons/unicons.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../widgets/profile_details.dart';
import '../../../../../widgets/profile_edit.dart';

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
            leadingWidth: deviceWidth * 0.07,
            leading: Ink(
              child: IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
                splashColor:
                    Colors.transparent, // Set splashColor to transparent
              ),
            ),
            title: Row(
              children: [
                Text(
                  'Profile Details',
                  style: AppFonts.poppinsMedium
                      .copyWith(fontSize: 22, color: AppColors.planeColor),
                ),
              ],
            ),
            actions: profileEditController.edit.value
                ? []
                : [
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          profileEditController._onedit();
                          profileEditController._getHiveData();
                        },
                        icon: Icon(
                          LineAwesomeIcons.pen,
                          color: AppColors.planeColor,
                        ))
                  ],
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
          ),
          body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Card(
                  elevation: 1,
                  margin: EdgeInsets.only(
                    top: deviceWidth * 0.0,
                  ),
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
                                      buttoncolor: AppColors.pricecalcontainer,
                                      oncallback: () {
                                        profileEditController._onedit();
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
                            ProfileDetails(
                              onpress: () {},
                              title: products.firstname,
                              subtitle: 'Fisrt Name',
                              deviceWidth: deviceWidth,
                              icon: LineAwesomeIcons.user,
                            ),
                            ProfileDetails(
                              onpress: () {},
                              title: products.lastname,
                              subtitle: 'Last Name',
                              deviceWidth: deviceWidth,
                              icon: LineAwesomeIcons.user_1,
                            ),
                            ProfileDetails(
                              onpress: () {},
                              title: products.email,
                              subtitle: 'Email',
                              deviceWidth: deviceWidth,
                              icon: Icons.email_outlined,
                            ),
                            ProfileDetails(
                              onpress: () {},
                              title: products.phonenumber,
                              subtitle: 'Phone',
                              icon: UniconsLine.phone,
                              deviceWidth: deviceWidth,
                            )
                          ],
                        ),
                ),
              ]))
            ],
          ),
        ));
  }
}

class ProfileEditController extends GetxController {
  var edit = false.obs;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  void _onedit() {
    edit.value = !edit.value;
  }

  void _getHiveData() {
    var box = Hive.box('homedata');
    var products = box.get('homedata');
    firstname.text = products.firstname;
    lastname.text = products.lastname;
    phoneNum.text = products.phonenumber;
    update();
  }
}
