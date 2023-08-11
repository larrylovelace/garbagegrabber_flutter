import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/src/widgets/snackbars/error_snackbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

import '../../../models/currentappointment.dart';
import '../../../models/homescreendata.dart';
import '../../../models/products.dart';
import '../../../../utils/colors.dart';
import '../../../../services/apihandler.dart';
import '../../date and time/datetime.dart';
import '../../routes.dart';
import '../../../../services/token_manager.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  final storage = const FlutterSecureStorage();
  String email = '';
  late HomeScreenData homescreendata;
  CurrentAppointment? currentAppointment;
  DateConverter dateConverter = DateConverter();
  String remainingdays = '';
  String pickupmonth = '';
  String pickupdate = '';
  // Your Hive box for storing data
  final homeDataBox = Hive.box('homedata');

  // Rx variable to store data from Hive

  // Rx variable to track if the data is fetched from the API

  Future<void> getHomeScreeData(BuildContext context) async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.hompagedata;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          homescreendata = HomeScreenData.fromJson(data);
          if (data['current_appointment'].isNotEmpty) {
            currentAppointment =
                CurrentAppointment.fromJson(data['current_appointment']);
            remainingdays = dateConverter
                .remainingdays(homescreendata.upcomingPickupDate)
                .toString();
            pickupmonth = dateConverter
                .getMonthFromDate(homescreendata.upcomingPickupDate);
            pickupdate = dateConverter
                .getDayFromDate(homescreendata.upcomingPickupDate)
                .toString();
          } else {}

          email = homescreendata.customerData.email;

          // Store product details in Hive

          final products = Products(
            firstname: homescreendata.customerData.firstName,
            lastname: homescreendata.customerData.lastName,
            email: homescreendata.customerData.email,
            phonenumber: homescreendata.customerData.phoneNumber,
            qrcodeno: homescreendata.customerData.qrCodeIdentifier,
            productDatas: List<ProductData>.from(
              homescreendata.allProducts.map((item) {
                return ProductData(
                  id: item.id,
                  name: item.name,
                  price: item.price,
                  plan: item.plan,
                );
              }),
            ),
          );

          homeDataBox.put('homedata', products);

          // Store the products object in the box

          // Store the products object in the box
        } else if (response.statusCode == 401) {
          var box = Hive.box('homedata');
          await box.clear();
          await storage.deleteAll();
          Get.offAllNamed(AppRoutes.login);
          // Show SnackBar using Get.snackbar (no need for context here)
          // ignore: use_build_context_synchronously
          CustomSnackBar.show(
            context,
            'Error',
            'Unauthorized',
            AppColors.errorColor, // Custom background color
            Icons.error_rounded, // Custom icon
            AppColors.errorColor, // Custom icon color
          );
        }
      } else {
        // Show SnackBar using Get.snackbar (no need for context here)
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          'Error',
          'Something went wrong',
          AppColors.errorColor, // Custom background color
          Icons.error_rounded, // Custom icon
          AppColors.errorColor, // Custom icon color
        );
        // Access token is expired or could not be obtained, handle accordingly
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }
    } catch (e) {
      // Show SnackBar using Get.snackbar (no need for context here)
      // ignore: use_build_context_synchronously
      CustomSnackBar.show(
        context,
        'Error',
        'Something went wrong',
        AppColors.errorColor, // Custom background color
        Icons.error_rounded, // Custom icon
        AppColors.errorColor, // Custom icon color
      );
    }
  }
}
