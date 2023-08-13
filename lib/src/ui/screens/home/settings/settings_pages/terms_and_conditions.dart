import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/utils/colors.dart';
import 'package:garbage_grabber/src/utils/fonts.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
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
              'Terms & Conditions',
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
              'User Terms and Conditions for Garbage Grabbers  App',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Welcome to the Garbage Grabbers  App. Before using the App, please read and agree to the following terms and conditions. By accessing or using the App, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions. If you do not agree with these terms, please do not use the App.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '1. Description of the App:',
              style: AppFonts.poppinsMedium.copyWith(fontSize: 16),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'The Garbage Grabbers  App provides a platform that enables users to schedule and request garbage collection services within their designated areas. The App may also offer additional features, such as recycling information and waste management resources.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '2. User Eligibility:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'By using the App, you represent and warrant that you are at least 18 years old or of legal age in your jurisdiction to enter into binding contracts. If you are using the App on behalf of a company or organization, you must have the necessary authority to do so.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '3. Account Creation and Security:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'To use certain features of the App, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account credentials (username and password) and for all activities that occur under your account. Notify us immediately if you suspect any unauthorized use of your account.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '4. Garbage Collection Services:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'The App facilitates the connection between users and waste management service providers . The actual garbage collection services are provided by third-party Service Providers, and the App does not guarantee the availability, quality, or timeliness of these services. Users are solely responsible for their interactions and transactions with Service Providers.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '5. Service Requests and Payments:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'Users may request garbage collection services through the App. Payment for these services shall be processed through the App or as agreed upon with the Service Providers. The App may charge a service fee for facilitating the payment process. Users agree to pay all applicable fees and taxes as required by law.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '6. Prohibited Activities:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "When using the App, you agree not to engage in the following activities:\na. Violating any applicable laws or regulations.\nb. Using the App for any illegal, harmful, or fraudulent purposes.\nc. Interfering with the App's functionality, security, or integrity.\nd. Uploading, transmitting, or distributing any harmful or malicious content, including viruses or malware.\ne. Impersonating another person or entity.\nf. Collecting data from other users without their consent.\ng. Engaging in any activity that may harm the reputation or business interests of the App.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '7. Intellectual Property:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "The App and its content, including but not limited to logos, trademarks, text, graphics, and software, are the property of the App's owners and are protected by copyright and other intellectual property laws.Users are not granted any rights or licenses to use the App's intellectual property without prior written consent from the App's owners.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '8. Privacy Policy:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "The App collects and processes user information in accordance with its Privacy Policy. By using the App, you consent to the collection and use of your information as described in the Privacy Policy.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '9. Termination of Access:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "The App reserves the right to suspend or terminate user access to the App at any time, with or without cause, and without prior notice. This may result from violations of these terms or for any other reason deemed appropriate by the App's owners.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '10. Disclaimer of Warranties:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "The App is provided on an basis, and the App's owners make no representations or warranties regarding its accuracy, reliability, or suitability for any purpose. The App's owners disclaim all warranties, whether express or implied, to the maximum extent permitted by law.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '11. Limitation of Liability:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "In no event shall the App's owners be liable for any indirect, consequential, incidental, special, or punitive damages arising out of or related to the use of the App, even if they have been advised of the possibility of such damages.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '12. Modifications to the Terms and Conditions:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              "The App's owners reserve the right to modify these terms and conditions at any time. Updated terms will be posted on the App, and your continued use of the App after the changes are posted constitutes acceptance of the revised terms.",
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              '13. Governing Law and Jurisdiction:',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Text(
              'These terms and conditions shall be governed by and construed in accordance with the law. Any disputes arising under these terms shall be subject to the exclusive jurisdiction of the courts in Nashville, Tennessee.',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'If you have any questions or concerns regarding these terms and conditions, please contact us at info@garbagegrabbers.app',
              style: AppFonts.poppinsRegular
                  .copyWith(fontSize: AppFonts.smalltext),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Thank you for using the Garbage Grabbers App!',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumtext),
            ),
            SizedBox(height: deviceHeight * 0.02),
            Text(
              'Larry Love\n678-943-5125',
              style: AppFonts.poppinsMedium
                  .copyWith(fontSize: AppFonts.mediumFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
