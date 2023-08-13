import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/utils/colors.dart';
import 'package:garbage_grabber/src/utils/fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.planeColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        
        automaticallyImplyLeading: true,
        titleSpacing: 4,
        title: Row(
          children: [
            Text(
              'About Us',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: 22, color: AppColors.planeColor),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.05,
              right: deviceWidth * 0.05,
              top: deviceHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Introducing Garbage Grabbers App - the revolutionary app that makes managing trash disposal a breeze!',
                  textAlign: TextAlign.justify,
                  style: AppFonts.poppinsMedium
                      .copyWith(fontSize: AppFonts.mediumFontSize)),
              SizedBox(height: deviceHeight * 0.02),
              Text(
                'With Garbage Grabbers, you can say goodbye to the hassle of taking out the trash yourself. This innovative app connects users with reliable and efficient waste collectors who will happily handle the dirty work for you.',
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                'Using Garbage Grabbers is incredibly simple. Just download the app, create an account, and input your location and preferred trash collection schedule. Whether you need regular pickups or a one-time service, Garbage Grabbers has got you covered.',
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                'Say farewell to those overflowing trash bins and unsightly garbage bags sitting around for days. Our dedicated team of waste professionals will promptly arrive at your doorstep, ensuring your trash is collected and disposed of responsibly.',
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                'Safety and reliability are paramount to us. All Garbage Grabbers collectors undergo thorough background checks and training to guarantee the highest level of service. You can rest easy knowing that your waste is in capable hands.',
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
                'Environmental consciousness is also at the core of Garbage Grabbers\' mission. Our collectors adhere to eco-friendly practices, promoting recycling and proper waste management to minimize the environmental impact.',
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Text(
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsRegular
                    .copyWith(fontSize: AppFonts.smalltext),
                'So why deal with the mess and stress of trash disposal when you can leave it to the experts? Embrace the convenience and efficiency of Garbage Grabbers and enjoy a cleaner, clutter-free living space without lifting a finger. Download the app today and let the Garbage Grabbers App take care of your trash, so you can focus on what truly matters in life.',
              ),
              SizedBox(height: deviceHeight * 0.03),
              Text(
                'Larry Love\n678-943-5125',
                textAlign: TextAlign.justify,
                style: AppFonts.poppinsMedium
                    .copyWith(fontSize: AppFonts.mediumFontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
