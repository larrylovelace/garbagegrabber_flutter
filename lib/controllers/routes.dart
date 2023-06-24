import 'package:garbage_grabber/pages/home/homescreen.dart';
import 'package:garbage_grabber/pages/screens/login.dart';
import 'package:garbage_grabber/pages/screens/signup.dart';
import 'package:get/get.dart';

import '../pages/screens/form_fill.dart';
import '../pages/screens/otp_screen.dart';
import '../pages/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpscreen = '/otpscreen';
  static const String formfill = '/formfill';
  static const String homescreen = '/homescreen';

  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      bindings: [
        OtpScreenBinding()
      ], // Set a transition animation for login screen
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
      bindings: [OtpScreenBinding()],
    ),
    GetPage(
      name: otpscreen,
      page: () => const OtpScreen(),
      binding: OtpScreenBinding(),
      transition: Transition.fadeIn,
      bindings: [FormFillScreenBinding()],
    ),
    GetPage(
      name: formfill,
      page: () => const FormFillScreen(),
      binding: FormFillScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homescreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Splash screen can be added here
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Login screen can be added here
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Register screen can be added here
  }
}

class OtpScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Otp screen can be added here
  }
}

class FormFillScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Fromfill screen can be added here
  }
}

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Home screen can be added here
  }
}
