import 'package:flutter/material.dart';

import '../../utils/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.text,
    required this.textcolor,
    required this.buttoncolor,
    required this.oncallback,
  });

  final double deviceHeight;
  final double deviceWidth;
  final String text;
  final Color textcolor;
  final Color buttoncolor;
  final VoidCallback oncallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.042,
      width: deviceWidth * 0.34,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            oncallback();
          },
          child: Text(
            text,
            style: AppFonts.poppinsLightMedium
                .copyWith(color: textcolor, fontSize: AppFonts.mediumtext),
          ),
        ),
      ),
    );
  }
}
