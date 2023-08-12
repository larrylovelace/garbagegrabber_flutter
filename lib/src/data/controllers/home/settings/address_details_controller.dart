import 'package:flutter/material.dart';
import 'package:garbage_grabber/src/data/models/address_details_models.dart';
import 'package:garbage_grabber/src/data/repositories/address_details_repo.dart';
import 'package:get/get.dart';

import '../../../../widgets/snackbars/error_handling.dart';

class AddressDetailsScreenController extends GetxController {
  final AddressDetailsRepository _addressDetailsRepository =
      AddressDetailsRepository();
  AddressDetailsModel? addressDetailsModel;
  Future<void> addressDetails(BuildContext context) async {
    try {
      Map<String, dynamic> data =
          await _addressDetailsRepository.addressDetailsRepo(context);
      addressDetailsModel = AddressDetailsModel.fromMap(data);
      update();
    } catch (e) {
      final snackBar = buildErrorSnackBar(context, e);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      debugPrint(e.toString());
    }
  }
}
