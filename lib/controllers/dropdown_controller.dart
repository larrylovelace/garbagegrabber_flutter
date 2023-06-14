import 'package:get/get.dart';

class DropDownController extends GetxController {
  bool apartmentothers = false;
  String dropdown = '';

  String get dropDownValue => dropdown;
  bool get apartmentothersValue => apartmentothers;
  void onSelecting(value) {
    dropdown = value;
    update();
    if (dropdown == 'Other') {
      apartmentothers = true;
    } else {
      apartmentothers = false;
    }
  }
}
