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
  var box = Hive.box('homedata');
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: deviceHeight > 1000 ? 100 : 50,
          title: Padding(
            padding: deviceHeight > 1000
                ? EdgeInsets.only(left: deviceWidth * 0.015)
                : EdgeInsets.zero,
            child: Row(
              children: [
                Text(
                  'Settings',
                  style: AppFonts.poppinsBold.copyWith(
                      fontSize: AppFonts.largeFontSize,
                      color: AppColors.kBlackColor),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                    padding: EdgeInsets.only(
                        bottom: deviceHeight * 0.02, top: deviceHeight * 0.02),
                    child: Column(
                      children: [
                        SettingsItems(
                            title: 'Profile Details',
                            deviceWidth: deviceWidth,
                            icon: LineAwesomeIcons.user,
                            onPress: (() {
                              Get.toNamed(AppRoutes.profiledetails);
                            })),
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                        SettingsItems(
                            title: 'Address Details',
                            deviceWidth: deviceWidth,
                            icon: Icons.location_on_outlined,
                            onPress: (() {
                              Get.toNamed(AppRoutes.addressdetails);
                            })),
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                        // SettingsItems(
                        //     title: 'Support',
                        //     deviceWidth: deviceWidth,
                        //     icon: Icons.support_outlined,
                        //     onPress: (() {})),
                        // deviceHeight > 1000
                        //     ? SizedBox(
                        //         height: deviceHeight * 0.04,
                        //       )
                        //     : const SizedBox(),
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
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                        SettingsItems(
                            title: 'Privacy Policy',
                            deviceWidth: deviceWidth,
                            icon: LineAwesomeIcons.user_shield,
                            onPress: (() {
                              Get.toNamed(AppRoutes.privacypolicy);
                            })),
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                        SettingsItems(
                            title: 'Terms and Conditions',
                            deviceWidth: deviceWidth,
                            icon: UniconsLine.document_info,
                            onPress: (() {
                              Get.toNamed(AppRoutes.termsandconditions);
                            })),
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
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
                        deviceHeight > 1000
                            ? SizedBox(
                                height: deviceHeight * 0.04,
                              )
                            : SizedBox(
                                height: deviceHeight * 0.01,
                              ),
                        SettingsItems(
                            title: 'Log Out',
                            icon: LineAwesomeIcons.alternate_sign_out,
                            deviceWidth: deviceWidth,
                            textColor: AppColors.kErrorColor,
                            endIcon: false,
                            onPress: (() async {
                              await box.clear();
                              await storage.deleteAll();
                              mainScreenController.resetController();
                              Get.offAllNamed(AppRoutes.login);

                              // ignore: use_build_context_synchronously
                              CustomSnackBar.show(
                                context,
                                'Logged out',
                              );
                            }))
                      ],
                    )),
              ]),
            ),
          ],
        ));
  }
}
