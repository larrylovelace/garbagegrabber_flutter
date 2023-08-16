import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../../services/apihandler.dart';
import '../../../data/controllers/routes.dart';
import '../../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final storage = const FlutterSecureStorage();
  bool showCircularIndicator = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.65, end: 0.85).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.repeat(reverse: true);

    // Simulate a delay of 3 seconds
    checkTokens();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void checkTokens() async {
    // Check if the tokens are present in the storage
    final refreshToken = await storage.read(key: 'refreshtoken');
    final accessToken = await storage.read(key: 'accesstoken');

    if (refreshToken != null && accessToken != null) {
      // Tokens are present, check if they are expired
      final bool refreshTokenExpired = await checkTokenExpiration(refreshToken);
      final bool accessTokenExpired = await checkTokenExpiration(accessToken);

      if (!refreshTokenExpired && !accessTokenExpired) {
        // Tokens are not expired, navigate to the main screen
        Get.offAllNamed(AppRoutes.screenhandler);
      } else if (!refreshTokenExpired && accessTokenExpired) {
        // Access token is expired, request new access token
        final newAccessToken = await requestNewAccessToken(refreshToken);

        if (newAccessToken != null) {
          // Update the access token in secure storage
          await storage.write(key: 'accesstoken', value: newAccessToken);

          // Tokens are updated, navigate to the main screen
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.offAllNamed(AppRoutes.screenhandler);
          });
        } else {
          // Failed to get a new access token, navigate to the login screen
        }
      } else {
        // Tokens are expired, delete them from secure storage
        await storage.deleteAll();
        // Navigate to the login screen
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }
    } else {
      // Tokens are not present, navigate to the login screen
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

  Future<bool> checkTokenExpiration(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    if (decodedToken.containsKey('exp')) {
      // Token has an expiration time
      final int expirationTimestamp = decodedToken['exp'];
      final DateTime expirationDate =
          DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
      debugPrint(expirationDate.toString());

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

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: deviceHeight * 0.01,
        backgroundColor: AppColors.kBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: showCircularIndicator
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return ScaleTransition(
                        scale: _scaleAnimation,
                        child: child,
                      );
                    },
                    child: SizedBox(
                      height: deviceHeight * 0.4,
                      child: Image.asset(
                        'assets/splash.png',
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
