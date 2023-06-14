import 'package:get/get.dart';

class PasswordController extends GetxController {
  bool loginPasswordVisibility = true;
  bool signupPasswordVisibility = true;
  bool get passwordObscuredlogin => loginPasswordVisibility;
  bool get passwordObscuredsignup => signupPasswordVisibility;

  void loginVisibility() {
    loginPasswordVisibility = !loginPasswordVisibility;
    update();
  }

  void signupVisibility() {
    signupPasswordVisibility = !signupPasswordVisibility;
    update();
  }
}
