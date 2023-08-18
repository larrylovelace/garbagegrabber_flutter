import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/widgets/global/error_dialog.dart';
import 'package:garbage_grabber/src/widgets/snackbars/error_handling.dart';
import 'package:garbage_grabber/src/widgets/snackbars/error_snackbar.dart';
import 'package:get/get.dart';
import '../../../../services/apihandler.dart';
import '../../../../services/token_manager.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import '../../routes.dart';

import 'package:http/http.dart' as http;

class SettingsScreenController extends GetxController {
  String errorHeader = '';
  String errorBody = '';
  RxString enteredCode = ''.obs;
  var isLoading = false.obs;
  var isotpInvalid = false.obs;
  var showResendText = true.obs;
  var box = Hive.box('homedata');
  final storage = const FlutterSecureStorage();
  Future<void> deleteAccount(BuildContext context) async {
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
        } else if (response.statusCode == 400) {
          Get.back();
          Map<String, dynamic> data = jsonDecode(response.body);
          // ignore: use_build_context_synchronously
          Get.dialog(ErrorDialog(
            deleteAccountDialog: true,
            deviceWidth: deviceWidth,
            deviceHeight: deviceHeight,
            headerText: data['error'],
            bodyText: data['message'],
          ));
        } else if (response.statusCode == 401) {
          await box.clear();
          await storage.deleteAll();
          Get.offAllNamed(AppRoutes.login);

          // ignore: use_build_context_synchronously
          CustomSnackBar.show(
            context,

            'Unauthorized',
            // Custom background color
          );
        }
      } else {
        // Handle the case when accessToken is null
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> verifyCode(BuildContext context) async {
    if (enteredCode.value.length == 6) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;

      try {
        final refreshToken = await storage.read(key: 'refreshtoken');

        final tokenManager = TokenManager();

        String? accessToken =
            await tokenManager.checkTokensAndRequestAccessToken(
                refreshToken!, APIConstants.tokenRefresh);

        if (accessToken != null) {
          String uri = APIConstants.baseURI + APIConstants.deleteCustomerVerify;

          var response = await http.post(Uri.parse(uri), headers: {
            'Authorization': 'Bearer $accessToken',
          }, body: {
            'otp': enteredCode.value,
          });

          if (response.statusCode == 200) {
            isLoading.value = false;
            await box.clear();
            await storage.deleteAll();
            Get.offAllNamed(AppRoutes.login);
            // ignore: use_build_context_synchronously
            CustomSnackBar.show(
              context,
              'Account Deleted Successfully',
            );
          } else if (response.statusCode == 400) {
            Map<String, dynamic> errormsg = jsonDecode(response.body);

            isotpInvalid.value = true;
            isLoading.value = false;
            // ignore: use_build_context_synchronously
            CustomSnackBar.show(
              context,

              errormsg['error'],
              // Custom background color
            );

            Future.delayed(const Duration(seconds: 5), () {
              isotpInvalid.value = false;
            });
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
