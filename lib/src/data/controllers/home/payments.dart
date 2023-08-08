import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../models/payments.dart';
import '../../../utils/colors.dart';
import '../../../widgets/error_handling.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../services/apihandler.dart';
import '../routes.dart';
import '../../../services/token_manager.dart';

class PaymentPageController extends GetxController {
  final storage = const FlutterSecureStorage();
  PaymentData? paymentdetails;
  ScrollController scrollController = ScrollController();

  double totaltransaction = 0;
  double recenttransaction = 0;
  bool dataempty = false;
  bool nopayments = false;

  Future<void> getTransactiondetails(BuildContext context) async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.transactions;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['grand_total'] == null) {
            nopayments = true;
          } else {
            paymentdetails = PaymentData.fromJson(data);
          }

          update();
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
        } else {
          Get.back();
          // ignore: use_build_context_synchronously
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
    } catch (e) {
      debugPrint(e.toString());
      Get.back();
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
