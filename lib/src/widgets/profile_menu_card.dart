import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key,
      required this.title,
      required this.icon,
      this.endIcon = true,
      required this.onPress,
      required this.deviceWidth,
      this.textColor})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: deviceWidth * 0.09,
        height: deviceWidth * 0.09,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.profileMenuIcon),
        child: Icon(icon, color: AppColors.primaryColor),
      ),
      title: Text(title,
          style: AppFonts.poppinsLightMedium
              .copyWith(fontSize: 14, letterSpacing: 0.1, color: textColor)),
      trailing: endIcon
          ? Container(
              width: deviceWidth * 0.08,
              height: deviceWidth * 0.08,
              decoration: BoxDecoration(
                  color: AppColors.profileMenuIcon, shape: BoxShape.circle),
              child: Icon(LineAwesomeIcons.angle_right,
                  size: 18, color: AppColors.pricecalcontainer),
            )
          : null,
    );
  }
}
