import 'package:get/get.dart';

class StepController extends GetxController {
  int currentStep = 0;

  int get currentPosition => currentStep;

  void onStepContinue() {
    currentStep += 1;

    update();
  }

  void onStepCancel() {
    currentStep -= 1;
    update();
  }
}
