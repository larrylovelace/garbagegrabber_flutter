import 'package:get/get.dart';

class SetupScreenController extends GetxController {
  bool apartmentothers = false;
  String dropdown = '';
  int currentStep = 0;
  bool loginPasswordVisibility = true;
  bool signupPasswordVisibility = true;
  bool isLoading = false;
  bool mailerror = false;
  bool phoneerror = false;
  String get dropDownValue => dropdown;
  String email = '';
  String password = '';
  bool get apartmentothersValue => apartmentothers;
  int get currentPosition => currentStep;
  bool get passwordObscuredlogin => loginPasswordVisibility;
  bool get passwordObscuredsignup => signupPasswordVisibility;
  bool get isindicatorLoading => isLoading;
  bool get errormail => mailerror;
  bool get phonenumerror => phoneerror;
  String errormailtext = '';
  String get errormailvalue => errormailtext;
  String errorphonetext = '';
  String get errorhponevalue => errorphonetext;
  String get sendemail => email;
  String get sendpassword => password;
  void onSelecting(value) {
    dropdown = value;
    update();
    if (dropdown == 'Other') {
      apartmentothers = true;
    } else {
      apartmentothers = false;
    }
  }

  void onStepContinue() {
    currentStep += 1;
    update();
  }

  void onStepCancel() {
    currentStep -= 1;
    update();
  }

  void loginVisibility() {
    loginPasswordVisibility = !loginPasswordVisibility;
    update();
  }

  void signupVisibility() {
    signupPasswordVisibility = !signupPasswordVisibility;
    update();
  }

  void isLoadingindicator() {
    isLoading = !isLoading;
    update();
  }

  void errormailoccur(value) {
    mailerror = true;
    errormailtext = value;
    update();
    Future.delayed(const Duration(seconds: 5), () {
      mailerror = false;
      errormailtext = '';
      update();
    });
  }

  void errorphoneoccur(value) {
    phoneerror = true;
    errorphonetext = value;
    update();
    Future.delayed(const Duration(seconds: 5), () {
      phoneerror = false;
      errorphonetext = '';
      update();
    });
  }

  void sendcredentials(value) {
    email = value[0];
    password = value[1];
  }
}
