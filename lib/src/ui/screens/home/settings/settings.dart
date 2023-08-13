import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/src/data/controllers/home/settings/settings_screen_controller.dart';
import 'package:garbage_grabber/src/ui/screens/home/screenhandler.dart';
import 'package:garbage_grabber/src/utils/fonts.dart';
import 'package:garbage_grabber/src/widgets/global/loading_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../data/controllers/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/home/settings/account_deletion_dialog.dart';
import '../../../../widgets/snackbars/error_snackbar.dart';

import '../../../../widgets/home/settings/settings_items.dart';
import 'package:unicons/unicons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final MainScreenController mainScreenController =
      Get.find<MainScreenController>();
  final SettingsScreenController settingsScreenController =
      Get.put(SettingsScreenController());
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var box = Hive.box('homedata');
    var products = box.get('homedata');
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Settings',
                style: AppFonts.poppinsMedium
                    .copyWith(fontSize: 22, color: AppColors.planeColor),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: products == null
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar.medium(
                        elevation: 1,
                        pinned: false,
                        floating: false,
                        backgroundColor: AppColors.primaryColor,
                        flexibleSpace: Container(
                          margin: EdgeInsets.only(
                              top: deviceHeight * 0.01,
                              left: deviceWidth * 0.04,
                              right: deviceWidth * 0.04),
                          height: deviceHeight * 0.1,
                          padding: EdgeInsets.only(left: deviceWidth * 0.05),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: AppColors.secondaryColor),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        products.firstname +
                                            ' ' +
                                            products.lastname,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.poppinsMedium
                                            .copyWith(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        products.email,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.poppinsRegular.copyWith(
                                            fontSize: AppFonts.smallFontSize),
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.02,
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: AppColors.primaryColor,
                                        size: 20,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ];
                },
                body: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        RawMaterialButton(
                            padding: EdgeInsets.only(
                                bottom: deviceHeight * 0.02,
                                top: deviceHeight * 0.02),
                            fillColor: AppColors.planeColor,
                            elevation: 0,
                            onPressed: () {},
                            child: Column(
                              children: [
                                SettingsItems(
                                    title: 'Profile Details',
                                    deviceWidth: deviceWidth,
                                    icon: LineAwesomeIcons.user,
                                    onPress: (() {
                                      Get.toNamed(AppRoutes.profiledetails);
                                    })),
                                SettingsItems(
                                    title: 'Address Details',
                                    deviceWidth: deviceWidth,
                                    icon: Icons.location_on_outlined,
                                    onPress: (() {
                                      Get.toNamed(AppRoutes.addressdetails);
                                    })),
                                SettingsItems(
                                    title: 'Support',
                                    deviceWidth: deviceWidth,
                                    icon: Icons.support_outlined,
                                    onPress: (() {})),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                const Divider(),
                                SizedBox(
                                  height: deviceHeight * 0.005,
                                ),
                                SettingsItems(
                                    title: 'About Us',
                                    icon: LineAwesomeIcons.info,
                                    deviceWidth: deviceWidth,
                                    onPress: (() {
                                      Get.toNamed(AppRoutes.aboutus);
                                    })),
                                SettingsItems(
                                    title: 'Privacy Policy',
                                    deviceWidth: deviceWidth,
                                    icon: LineAwesomeIcons.user_shield,
                                    onPress: (() {
                                      Get.toNamed(AppRoutes.privacypolicy);
                                    })),
                                SettingsItems(
                                    title: 'Terms and Conditions',
                                    deviceWidth: deviceWidth,
                                    icon: UniconsLine.document_info,
                                    onPress: (() {
                                      Get.toNamed(AppRoutes.termsandconditions);
                                    })),
                                SettingsItems(
                                    title: 'Account Deletion',
                                    deviceWidth: deviceWidth,
                                    icon: Icons.delete_forever_outlined,
                                    onPress: (() {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AccountDeletionDialog(
                                              deviceWidth: deviceWidth,
                                              deviceHeight: deviceHeight,
                                              settingsScreenController:
                                                  settingsScreenController,
                                              headerText: 'Delete Account ?',
                                              bodyText:
                                                  'This will delete your Garbage Grabbers account and all the data associated with it',
                                              onPressed1: () {
                                                Get.back();
                                              },
                                              onPressed2: () {
                                                Get.back();
                                                LoadingDialog.show(context);

                                                settingsScreenController
                                                    .deleteAccount(context);
                                              },
                                            );
                                          });
                                    })),
                                SettingsItems(
                                    title: 'Log Out',
                                    icon: LineAwesomeIcons.alternate_sign_out,
                                    deviceWidth: deviceWidth,
                                    textColor: AppColors.errorColor,
                                    endIcon: false,
                                    onPress: (() async {
                                      await box.clear();
                                      await storage.deleteAll();
                                      mainScreenController.resetController();
                                      Get.offAllNamed(AppRoutes.login);

                                      // ignore: use_build_context_synchronously
                                      CustomSnackBar.show(
                                        context,
                                        'Success',
                                        'Logged out',
                                        AppColors
                                            .errorColor, // Custom background color
                                        Icons.check, // Custom icon
                                        AppColors
                                            .errorColor, // Custom icon color
                                      );
                                    }))
                              ],
                            )),
                      ]),
                    ),
                  ],
                )));
  }
}
