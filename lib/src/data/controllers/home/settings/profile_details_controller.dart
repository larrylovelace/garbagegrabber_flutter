import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ProfileEditController extends GetxController {
  var edit = false.obs;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  void onEdit() {
    edit.value = !edit.value;
  }

  void getHiveData() {
    var box = Hive.box('homedata');
    var products = box.get('homedata');
    firstname.text = products.firstname;
    lastname.text = products.lastname;
    phoneNum.text = products.phonenumber;
    update();
  }
}
