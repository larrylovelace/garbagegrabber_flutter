import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool ispriceChange = false;
  bool get pricechanged => ispriceChange;
  bool isdatepicked = false;
  bool get datepicked => isdatepicked;
  var price = '';
  get totalprice => price;
  var formatteddate = '';
  get date => formatteddate;
  void quantitycaclculation(value) {
    price = value;
    ispriceChange = true;
    update();
  }

  void getdate(date) {
    formatteddate = date;
    isdatepicked = true;
    update();
  }
}
