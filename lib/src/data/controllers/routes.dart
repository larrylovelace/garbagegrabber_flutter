import 'package:garbage_grabber/src/ui/screens/home/settings/account_deletion/account_del_otp.dart';
import 'package:garbage_grabber/src/ui/screens/home/settings/settings_pages/about_us.dart';
import 'package:garbage_grabber/src/ui/screens/home/settings/settings_pages/address_details.dart';
import 'package:garbage_grabber/src/ui/screens/home/settings/settings_pages/privacy_policy.dart';
import 'package:garbage_grabber/src/ui/screens/home/settings/settings_pages/profile_details.dart';
import 'package:garbage_grabber/src/ui/screens/home/settings/settings_pages/terms_and_conditions.dart';
import 'package:get/get.dart';
import '../../ui/screens/home/home screen/homescreen.dart';
import '../../ui/screens/home/screenhandler.dart';
import '../../ui/screens/home/payments/payment_success.dart';
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
  static const String accountdelotp = '/accountdelotp';
  static const String formfill = '/formfill';
  static const String screenhandler = '/screenhandler';
  static const String homescreen = '/homescreen';
  static const String paymentsuccess = '/paymentsuccess';
  static const String profiledetails = '/profiledetails';
  static const String addressdetails = '/addressdetails';
  static const String aboutus = '/aboutus';
  static const String privacypolicy = '/privacypolicy';
  static const String termsandconditions = '/termsandconditions';

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
      transition: Transition.upToDown,
      bindings: [
        OtpScreenBinding()
      ], // Set a transition animation for login screen
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.downToUp,
      bindings: [OtpScreenBinding()],
    ),
    GetPage(
      name: otpscreen,
      page: () => const OtpScreen(),
      binding: OtpScreenBinding(),
      transition: Transition.downToUp,
      bindings: [FormFillScreenBinding()],
    ),
    GetPage(
      name: formfill,
      page: () => const FormFillScreen(),
      binding: FormFillScreenBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: screenhandler,
      page: () => const MainScreen(),
      binding: MainScreenBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
        name: homescreen,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding(),
        transition: Transition.downToUp,
        bindings: [PaymentSuccessScreenBinding()]),
    GetPage(
      name: paymentsuccess,
      page: () => const PaymentSuccess(),
      binding: PaymentSuccessScreenBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
        name: profiledetails,
        page: () => const ProfileDetis(),
        binding: ProfileDetailsScreenBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: addressdetails,
        page: () => const AddressDetailsScreen(),
        binding: AddressDetailsScreenBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: aboutus,
        page: () => const AboutUsScreen(),
        binding: AboutUsScreenBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: privacypolicy,
        page: () => const PrivacyPolicyScreen(),
        binding: PrivacyPolicyScreenBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: termsandconditions,
        page: () => const TermsAndConditionsScreen(),
        binding: TermsAndConditionsScreenBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: accountdelotp,
        page: () => const AccountDeletionOTP(),
        bindings: [MainScreenBinding()],
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

class AddressDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Address Details screen can be added here
  }
}

class AboutUsScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the AboutUs screen can be added here
  }
}

class PrivacyPolicyScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the PrivacyPolicy screen can be added here
  }
}

class TermsAndConditionsScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Dependencies for the Terms and Conditions screen can be added here
  }
}
