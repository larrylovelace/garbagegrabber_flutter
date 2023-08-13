import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
    required this.onpress,
    required this.deviceWidth,
    this.textColor,
    this.leadingicon = true,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData? icon;
  final Function onpress;
  final Color? textColor;
  final double deviceWidth;
  final bool leadingicon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onpress();
      },
      contentPadding: EdgeInsets.only(left: deviceWidth * 0.03),
      minLeadingWidth: deviceWidth * 0.1,
      leading: leadingicon
          ? Container(
              width: deviceWidth * 0.09,
              height: deviceWidth * 0.09,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.profileMenuIcon),
              child: Icon(icon, color: AppColors.primaryColor),
            )
          : const SizedBox(),
      title: Row(
        children: [
          Text(title,
              style: AppFonts.poppinsLightMedium.copyWith(
                  fontSize: 14, letterSpacing: 0.1, color: textColor)),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: AppFonts.poppinsRegular
            .copyWith(fontSize: AppFonts.smallFontSize, letterSpacing: 0.3),
      ),
    );
  }
}
