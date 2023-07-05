import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenController extends GetxController {
  bool isloading = false;
  bool get indicatorloading => isloading;
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
  var outputdate = '';
  get sendinddate => outputdate;
  get date => formatteddate;
  double priceindouble = 0.0;
  double get finalpayingprice => priceindouble;

  void quantitycaclculation(value) {
    price = double.parse(value); // Parse value to double
    pricewithvat = ((8.5 / 100) * price + price);
    double roundedPrice = (pricewithvat * 100).ceilToDouble() / 100;
    payingprice = roundedPrice.toStringAsFixed(2);
    priceindouble = double.parse(payingprice!);

    ispriceChange = true;
    update();
  }

  void getdate(date) {
    formatteddate = date;
    String inputDate = formatteddate;
    DateFormat inputFormat = DateFormat('EEEE , MMM-dd-yyyy');
    DateTime finaldate = inputFormat.parse(inputDate);

    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    outputdate = outputFormat.format(finaldate);

    // Output: 2023-07-26
    isdatepicked = true;
    update();
  }

  void loading() {
    isloading = !isloading;

    update();
  }
}
