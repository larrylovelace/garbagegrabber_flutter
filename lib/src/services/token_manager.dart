import 'dart:convert';
import 'package:garbage_grabber/src/data/controllers/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'apihandler.dart';

class TokenManager {
  Future<String?> checkTokensAndRequestAccessToken(
      String refreshToken, String apiEndpoint) async {
    const storage = FlutterSecureStorage();
    final refreshTokenExpired = await checkTokenExpiration(refreshToken);
    final accessToken = await storage.read(key: 'accesstoken');

    if (accessToken != null) {
      final accessTokenExpired = await checkTokenExpiration(accessToken);

      if (!accessTokenExpired) {
        // Access token is not expired, directly make the API call
        return accessToken;
      }
    }

    if (refreshTokenExpired) {
      // Both tokens are expired, navigate to the login screen
      await storage.delete(key: 'refreshtoken');
      await storage.delete(key: 'accesstoken');

      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.login);
      });
      return null;
    }

    // Access token is expired, request a new access token
    final newAccessToken = await requestNewAccessToken(refreshToken);

    if (newAccessToken != null) {
      // Update the access token in secure storage
      await storage.write(key: 'accesstoken', value: newAccessToken);
      return newAccessToken;
    } else {
      // Failed to get a new access token, navigate to the login screen
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.login);
      });
      return null;
    }
  }
}

Future<bool> checkTokenExpiration(String token) async {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

  if (decodedToken.containsKey('exp')) {
    // Token has an expiration time
    final int expirationTimestamp = decodedToken['exp'];
    final DateTime expirationDate =
        DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);

    final DateTime currentDate = DateTime.now();

    // Compare the expiration date with the current date
    return currentDate.isAfter(expirationDate);
  }

  // Token does not have an expiration time
  return false;
}

Future<String?> requestNewAccessToken(String refreshToken) async {
  try {
    String uri = APIConstants.baseURI + APIConstants.tokenRefresh;
    var response = await http.post(Uri.parse(uri), body: {
      "refresh": refreshToken,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final newAccessToken = data['access'];
      return newAccessToken;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
