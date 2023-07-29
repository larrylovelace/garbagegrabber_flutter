import 'package:garbage_grabber/src/ui/screens/home/settings/pages/profile_details.dart';
import 'package:get/get.dart';
import '../../ui/screens/home/homescreen.dart';
import '../../ui/screens/home/mainscreen.dart';
import '../../ui/screens/home/payment_success.dart';
import '../../ui/screens/start/form_fill.dart';
import '../../ui/screens/start/login.dart';
import '../../ui/screens/start/otp_screen.dart';
import '../../ui/screens/start/signup.dart';
import '../../ui/screens/start/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpscreen = '/otpscreen';
  static const String formfill = '/formfill';
  static const String mainscreen = '/mainscreen';
  static const String homescreen = '/homescreen';
  static const String paymentsuccess = '/paymentsuccess';
  static const String profiledetails = '/profiledetails';

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
      name: mainscreen,
      page: () => const MainScreen(),
      binding: MainScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: homescreen,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding(),
        transition: Transition.fadeIn,
        bindings: [PaymentSuccessScreenBinding()]),
    GetPage(
      name: paymentsuccess,
      page: () => const PaymentSuccess(),
      binding: PaymentSuccessScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: profiledetails,
        page: () => const ProfileDetis(),
        binding: ProfileDetailsScreenBinding(),
        transition: Transition.fadeIn),
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

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Main screen can be added here
  }
}

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Home screen can be added here
  }
}

class PaymentSuccessScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Payment Success screen can be added here
  }
}

class ProfileDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Profile Details screen can be added here
  }
}
