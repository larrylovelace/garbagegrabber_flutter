import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/apihandler.dart';
import '../../../../services/token_manager.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/home/settings/account_deletion_error_dialog.dart';
import '../../../../widgets/snackbars/error_handling.dart';
import '../../../../widgets/snackbars/error_snackbar.dart';
import '../../routes.dart';

import 'package:http/http.dart' as http;

class SettingsScreenController extends GetxController {
  String errorHeader = '';
  String errorBody = '';
  var enteredCode = '';
  var isLoading = false.obs;
  var isotpInvalid = false.obs;
  int countdown = 60;
  var showResendText = true.obs;
  final storage = const FlutterSecureStorage();
  Future<void> deleteAccount(BuildContext context) async {
    var box = Hive.box('homedata');
    var products = box.get('homedata');
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.deleteCustomer;

        var response = await http.delete(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });
        if (response.statusCode == 200) {
          Get.back();
          showResendText.value = true;
          Get.toNamed(AppRoutes.accountdelotp,
              arguments: {'email': products.email});
        } else if (response.statusCode == 401) {
          Get.back();
          Map<String, dynamic> data = jsonDecode(response.body);
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return AccountDeletionErrorDialog(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    data: data);
              });
        } else if (response.statusCode == 401) {
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
        // Handle the case when accessToken is null
      }
    } catch (e) {
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> verifyCode(BuildContext context) async {
    if (enteredCode.length == 6) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;

      try {
        String uri = APIConstants.baseURI + APIConstants.customerOtpValidate;
        var response =
            await http.post(Uri.parse(uri), body: {"otp": enteredCode});

        if (response.statusCode == 200) {
          isLoading.value = false;

          // ignore: use_build_context_synchronously
        }

        if (response.statusCode == 400) {
          var errormsg = jsonDecode(response.body) as Map;

          isotpInvalid.value = true;
          isLoading.value = false;
          // ignore: use_build_context_synchronously
          CustomSnackBar.show(
            context,
            'Error',
            errormsg['error'],
            AppColors.errorColor, // Custom background color
            Icons.error_rounded, // Custom icon
            AppColors.errorColor, // Custom icon color
          );

          Future.delayed(const Duration(seconds: 5), () {
            isotpInvalid.value = false;
          });
        }
      } catch (e) {
        isLoading.value = false;
        final snackBar = buildErrorSnackBar(context, e);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // Trigger verification process here
    }
  }
}
