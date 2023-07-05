import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/controllers/routes.dart';
import 'package:garbage_grabber/utils/colors.dart';
import 'package:garbage_grabber/utils/fonts.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../widgets/error_snackbar.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.email})
      : super(key: key);

  final String firstname;
  final String lastname;
  final String email;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.9,
      child: Drawer(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        width: deviceWidth * 0.52,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: deviceHeight * 0.2,
                width: deviceWidth,
                decoration: BoxDecoration(color: AppColors.planeColor),
                child: Padding(
                  padding: EdgeInsets.only(left: deviceWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Container(
                        height: deviceHeight * 0.09,
                        width: deviceWidth * 0.15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor),
                        child: Center(
                            child: Text(
                          widget.firstname.substring(0, 1).toUpperCase(),
                          style: AppFonts.poppinsBold.copyWith(
                              color: AppColors.planeColor, fontSize: 30),
                        )),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.firstname,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.poppinsMedium
                                  .copyWith(fontSize: AppFonts.mediumFontSize),
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * 0.02,
                          ),
                          Expanded(
                            child: Text(
                              widget.lastname,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.poppinsMedium
                                  .copyWith(fontSize: AppFonts.mediumFontSize),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          widget.email,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppFonts.poppinsRegular
                              .copyWith(fontSize: AppFonts.smallFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DrawerTitleCards(
                  onPress: () {},
                  logout: false,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  title: 'Profile',
                  icon: Icons.person_2_outlined),
              DrawerTitleCards(
                  onPress: () {
                    Get.back();
                    Get.toNamed(AppRoutes.transactions);
                  },
                  logout: false,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  title: 'Transactions',
                  icon: Icons.payment_outlined),
              DrawerTitleCards(
                  onPress: () {},
                  logout: false,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  title: 'Notifications',
                  icon: Icons.notifications_active_outlined),
              DrawerTitleCards(
                  onPress: () {},
                  logout: false,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  title: 'Settings',
                  icon: Icons.settings_outlined),
              DrawerTitleCards(
                  onPress: () async {
                    var box = Hive.box('products');
                    await box.clear();
                    await storage.deleteAll();

                    // ignore: use_build_context_synchronously
                    CustomSnackBar.show(
                      context,
                      'Success',
                      'Loggedout successfully',
                      AppColors.errorColor, // Custom background color
                      Icons.check, // Custom icon
                      AppColors.errorColor, // Custom icon color
                    );
                    Get.offAllNamed(AppRoutes.login);
                  },
                  logout: true,
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                  title: 'Logout',
                  icon: Icons.logout_rounded)
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTitleCards extends StatelessWidget {
  const DrawerTitleCards(
      {super.key,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.icon,
      required this.title,
      required this.logout,
      required this.onPress});

  final double deviceWidth;
  final double deviceHeight;
  final IconData icon;
  final String title;
  final bool logout;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
          left: deviceWidth * 0.02,
          top: deviceHeight * 0.01,
          right: deviceWidth * 0.02),
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: deviceWidth * 0.012),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        onTap: onPress,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: logout ? AppColors.errorColor : AppColors.primaryColor,
              size: 25,
            ),
            SizedBox(
              width: deviceWidth * 0.03,
            ),
            Text(title,
                style: AppFonts.poppinsLightMedium.copyWith(
                    fontSize: AppFonts.smallFontSize,
                    color: AppColors.pricecalcontainer)),
          ],
        ),
      ),
    );
  }
}
