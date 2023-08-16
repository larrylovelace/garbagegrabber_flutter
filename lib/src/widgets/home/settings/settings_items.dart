import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class SettingsItems extends StatelessWidget {
  const SettingsItems(
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
    double deviceHeight = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: onPress,
      leading: CircleAvatar(
        backgroundColor: deviceHeight > 1000
            ? Colors.transparent
            : AppColors.kPrimaryColor.withOpacity(0.1),
        radius: deviceHeight * 0.024,
        child: Center(
          child: Icon(
            icon,
            color: AppColors.kPrimaryColor,
            size: AppFonts.largeFontSize,
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          deviceHeight > 1000
              ? SizedBox(
                  width: deviceWidth * 0.02,
                )
              : const SizedBox(),
          Text(title,
              style: AppFonts.poppinsLightMedium.copyWith(
                  fontSize: AppFonts.smallFontSize,
                  letterSpacing: 0.1,
                  color: textColor)),
        ],
      ),
      trailing: endIcon
          ? Container(
              width: deviceWidth * 0.08,
              height: deviceWidth * 0.08,
              decoration: BoxDecoration(
                  color: AppColors.profileMenuIcon, shape: BoxShape.circle),
              child: Icon(LineAwesomeIcons.angle_right,
                  size: AppFonts.mediumFontSize,
                  color: AppColors.kCancelButtonColor),
            )
          : null,
    );
  }
}
