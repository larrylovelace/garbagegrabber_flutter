import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool ispriceChange = false;
  bool get pricechanged => ispriceChange;
  bool isdatepicked = false;
  bool get datepicked => isdatepicked;
  double price = 0.0; // Updated to double data type
  double pricewithvat = 0.0; // Updated to double data type
  double get finalprice => pricewithvat; // Updated to double data type
  double get totalprice => price;
  String? payingprice; // Updated to double data type
  var formatteddate = '';
  get date => formatteddate;
  void quantitycaclculation(value) {
    price = double.parse(value); // Parse value to double
    pricewithvat = (8.5 / 100) * price + price;
    payingprice = pricewithvat.toStringAsFixed(2);
    ispriceChange = true;
    update();
  }

  void getdate(date) {
    formatteddate = date;
    isdatepicked = true;
    update();
  }
}
