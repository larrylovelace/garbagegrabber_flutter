import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;

import '../../models/payments.dart';
import '../../pages/home/product_detail.dart';
import '../../widgets/error_handling.dart';
import '../apihandler.dart';
import '../token_manager.dart';

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
        } else {
          Get.back();
          // ignore: use_build_context_synchronously
          showErrorDialog(context);
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

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ProudctValidation(
          deviceHeight: MediaQuery.of(context).size.height,
          deviceWidth: MediaQuery.of(context).size.width,
          headertext: 'Error',
          errortext: 'Something went wrong',
        );
      },
    );
  }
}
