// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/homescreen_controller.dart';
// import '../../utils/colors.dart';
// import '../../utils/fonts.dart';
// import '../../widgets/calendar_dialog.dart';
// import '../../widgets/dropdown.dart';

// class ProductDetail extends StatefulWidget {
//   const ProductDetail({super.key});

//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   HomeScreenController controller = Get.put(HomeScreenController());

//   var items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
//   @override
//   Widget build(BuildContext context) {
//     double deviceHeight = MediaQuery.of(context).size.height;
//     double deviceWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         controller.ispriceChange = false;
//         controller.isdatepicked = false;
//         showModalBottomSheet(
//             isScrollControlled: true,
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30))),
//             context: context,
//             builder: (context) => GetBuilder<HomeScreenController>(
//                   builder: (controller) {
//                     return Padding(
//                       padding: const EdgeInsets.all(30),
//                       child: SizedBox(
//                         height: deviceHeight * 0.86,
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(10),
//                                       topRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                   color: AppColors.secondaryColor,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         offset: const Offset(0, 10),
//                                         blurRadius: 40,
//                                         color: AppColors.primaryColor
//                                             .withOpacity(0.3))
//                                   ]),
//                               child:
//                                   Image.asset('assets/Onebag-transparent.png'),
//                             ),
//                             SizedBox(
//                               height: deviceHeight * 0.02,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       text,
//                                       style: AppFonts.poppinsMedium
//                                           .copyWith(fontSize: 20),
//                                     ),
//                                     controller.pricechanged
//                                         ? Text(
//                                             '\$${controller.totalprice}',
//                                             style: AppFonts.poppinsMedium
//                                                 .copyWith(
//                                                     color:
//                                                         AppColors.primaryColor,
//                                                     fontSize: 20),
//                                           )
//                                         : Text(
//                                             '\$$price',
//                                             style: AppFonts.poppinsMedium
//                                                 .copyWith(
//                                                     color:
//                                                         AppColors.primaryColor,
//                                                     fontSize: 20),
//                                           )
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(timeperiod,
//                                         style: AppFonts.poppinsRegular.copyWith(
//                                             fontSize: 17,
//                                             color: AppColors.primaryColor
//                                                 .withOpacity(0.9)))
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: deviceHeight * 0.02,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text('Quantity',
//                                         style: AppFonts.poppinsRegular
//                                             .copyWith(fontSize: 17))
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: deviceHeight * 0.01,
//                                 ),
//                                 SizedBox(
//                                   width: deviceWidth * 0.19,
//                                   child: DropDown(
//                                       hintText: '    1',
//                                       currentSelectedValue: '1',
//                                       selectingCategory: items,
//                                       heightofCategory: deviceHeight * 0.3,
//                                       onSelecting: (value) {
//                                         int intValue = int.parse(value);
//                                         double pricevalue = double.parse(
//                                             price); // Convert string to int
//                                         var total = intValue * pricevalue;
//                                         var totalprice =
//                                             total.toStringAsFixed(2);
//                                         controller
//                                             .quantitycaclculation(totalprice);
//                                       },
//                                       formvalidation: (value) {}),
//                                 ),
//                                 SizedBox(
//                                   height: deviceHeight * 0.02,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text('Select pickup date',
//                                         style: AppFonts.poppinsRegular
//                                             .copyWith(fontSize: 17))
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: deviceHeight * 0.01,
//                                 ),
//                                 Container(
//                                   height: deviceHeight * 0.05,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(6),
//                                       color: AppColors.fillColor),
//                                   child: MaterialButton(
//                                     onPressed: () {
//                                       showModalBottomSheet(
//                                           isScrollControlled: true,
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(30),
//                                                 topRight: Radius.circular(30)),
//                                           ),
//                                           context: context,
//                                           builder: (context) =>
//                                               const CalendarDialog());
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Icon(
//                                           Icons.date_range_outlined,
//                                           color: AppColors.iconColor,
//                                         ),
//                                         SizedBox(
//                                           width: deviceWidth * 0.02,
//                                         ),
//                                         controller.datepicked
//                                             ? Text(
//                                                 controller.date,
//                                                 style: AppFonts.poppinsRegular
//                                                     .copyWith(
//                                                         fontSize: AppFonts
//                                                             .smallFontSize,
//                                                         letterSpacing: 0.5),
//                                               )
//                                             : Text(
//                                                 'Pickup date',
//                                                 style: AppFonts.poppinsRegular
//                                                     .copyWith(
//                                                         fontSize: AppFonts
//                                                             .smallFontSize,
//                                                         color:
//                                                             AppColors.iconColor,
//                                                         letterSpacing: 0.5),
//                                               )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: deviceHeight * 0.14,
//                             ),
//                             Container(
//                               height: deviceHeight * 0.05,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: AppColors.primaryColor),
//                               child: MaterialButton(
//                                 onPressed: () {},
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Pay ',
//                                       style: AppFonts.poppinsLightMedium
//                                           .copyWith(
//                                               color: AppColors.planeColor,
//                                               fontSize:
//                                                   AppFonts.mediumFontSize),
//                                     ),
//                                     controller.ispriceChange
//                                         ? Text(
//                                             '\$${controller.totalprice}',
//                                             style: AppFonts.poppinsBold
//                                                 .copyWith(
//                                                     color: AppColors.planeColor,
//                                                     fontSize: AppFonts
//                                                         .mediumFontSize),
//                                           )
//                                         : Text(
//                                             '\$$price',
//                                             style: AppFonts.poppinsBold
//                                                 .copyWith(
//                                                     color: AppColors.planeColor,
//                                                     fontSize: AppFonts
//                                                         .mediumFontSize),
//                                           ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ));
//       },
//       child: Container(
//         margin: EdgeInsets.only(
//             left: deviceWidth * 0.02,
//             right: deviceWidth * 0.02,
//             top: deviceHeight * 0.02,
//             bottom: deviceHeight * 0.02),
//         width: deviceWidth * 0.45,
//         child: Column(
//           children: [
//             Image.asset(image),
//             Container(
//               padding: EdgeInsets.only(
//                   left: deviceHeight * 0.02,
//                   top: deviceHeight * 0.04,
//                   right: deviceHeight * 0.02),
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10)),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         offset: const Offset(0, 10),
//                         blurRadius: 50,
//                         color: AppColors.primaryColor.withOpacity(0.23))
//                   ]),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           text,
//                           style: AppFonts.poppinsMedium.copyWith(fontSize: 12),
//                         ),
//                       ),
//                       Text(
//                         '\$$price',
//                         style: AppFonts.poppinsMedium.copyWith(
//                             color: AppColors.primaryColor, fontSize: 12),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         timeperiod,
//                         style: AppFonts.poppinsRegular.copyWith(
//                             color: AppColors.primaryColor.withOpacity(0.9)),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
