import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../services/apihandler.dart';
import '../../services/token_manager.dart';
import 'package:http/http.dart' as http;
import '../../utils/colors.dart';
import '../../widgets/snackbars/error_handling.dart';
import '../../widgets/snackbars/error_snackbar.dart';
import '../controllers/routes.dart';

class PickupsRepository {
  final storage = const FlutterSecureStorage();
  Future<Map<String, dynamic>> pickupsRepo(BuildContext context) async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.registerappointment;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);

          return data;
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
        return {};
        // Handle the case when accessToken is null
      }
    } catch (e) {
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return {};
  }
}
