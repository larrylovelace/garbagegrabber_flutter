import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/utils/colors.dart';
import 'package:garbage_grabber/src/utils/fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
              'Privacy Policy',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: 22, color: AppColors.planeColor),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: deviceWidth * 0.05,
            right: deviceWidth * 0.05,
            top: deviceHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Garbage Grabbers App',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'Effective Date: July, 25th 2023',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smallFontSize),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'At Garbage Grabbers App, we are committed to protecting the privacy and security of your personal information...',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Information We Collect:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              '1.1. Personal Information: When you use our App, we may collect certain personal information, such as your name, address, email address, phone number, and location data.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '1.2. Device Information: We may collect information about the device you use to access the App, including but not limited to your device type, operating system, unique device identifier, and mobile network information.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '1.3. Usage Data: We may collect information about how you use the App, including the features you interact with, the time and date of your interactions, and your preferences.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'How We Use Your Information:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              '2.1. Providing Services: We use your personal information to provide you with garbage collection services, optimize collection routes, and improve overall service efficiency.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2.2. Communication: We may use your contact information to send you service-related updates, notifications, and important announcements about the App.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2.3. Analytics: We may analyze the usage data to understand user behavior, identify trends, and improve the App\'s functionality and user experience.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2.4. Legal Compliance: We may use your information to comply with applicable laws, regulations, or legal processes.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Data Sharing and Disclosure:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              '3.1. Third-Party Service Providers: We may share your information with trusted third-party service providers who assist us in providing and maintaining the App\'s features. These providers are bound by confidentiality obligations and are not allowed to use your data for other purposes.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3.2. Legal Requirements: We may disclose your information if required by law or in response to valid legal requests, such as court orders or government investigations.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3.3. Business Transfers: In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred to the acquiring entity.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Data Security:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'We implement reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of data transmission over the internet or electronic storage is entirely secure, and we cannot guarantee absolute security.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Data Retention:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'We will retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, or as required by law.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Children\'s Privacy:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you believe we have inadvertently collected information from a child under 13, please contact us immediately.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Your Choices:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'You may have the right to access, correct, or delete the personal information we hold about you. You can update your account settings within the App or contact us for assistance.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Changes to this Privacy Policy:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any material changes by posting the updated Privacy Policy on the App or through other communication channels.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Contact Us:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at info@garbagegrabbers.app',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'By using the Garbage Grabbers App, you signify your understanding and acceptance of this Privacy Policy. If you do not agree with this policy, please do not use the App.',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Larry Love\n678-943-5125',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
