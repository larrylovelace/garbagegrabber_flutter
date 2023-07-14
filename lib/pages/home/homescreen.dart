import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:garbage_grabber/models/homepagemodel.dart';

import 'package:garbage_grabber/models/products.dart';
import 'package:garbage_grabber/models/upcomingpickups.dart';

import 'package:garbage_grabber/pages/home/product_detail.dart';

import 'package:garbage_grabber/utils/colors.dart';

import 'package:garbage_grabber/utils/fonts.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

// import 'package:intl/intl.dart';

import '../../controllers/apihandler.dart';
import '../../controllers/homescreen_controller.dart';
import '../../controllers/routes.dart';
import '../../controllers/token_manager.dart';

import 'package:http/http.dart ' as http;

import '../../models/customers.dart';
import '../../models/datetime.dart';
import '../../widgets/error_handling.dart';
import '../../widgets/error_snackbar.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.put(HomeScreenController());
  final storage = const FlutterSecureStorage();
  String email = '';
  CustomerData? incomingdata;
  DateConverter dateConverter = DateConverter();

  List<String> images = [
    'assets/Onebag.png',
    'assets/Onebag.png',
    'assets/Onebag.png',
    'assets/Onebag.png',
  ];
  UserData? userData; // Declare userData in the state

  Future<void> getHomeScreeData() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.hompagedata;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        // debugPrint(response.body.toString());

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          incomingdata = CustomerData.fromJson(data);

          email = incomingdata!.customerData!.email!;

          // Store product details in Hive

          final productsBox = Hive.box('products');

          final products = Products(
            firstname: incomingdata!.customerData!.firstName!,
            lastname: incomingdata!.customerData!.lastName!,
            email: incomingdata!.customerData!.email!,
            phonenumber: incomingdata!.customerData!.phoneNumber!,
            qrcodeno: incomingdata!.customerData!.qrCodeIdentifier!,
            productDatas:
                List<ProductData>.from(incomingdata!.allProducts!.map((item) {
              return ProductData(
                id: item.id!,
                name: item.name!,
                price: item.price!.toDouble(),
                plan: item.plan!,
              );
            })),
          );

          productsBox.put('products', products);

          // Store the products object in the box
        } else if (response.statusCode == 401) {
          var box = Hive.box('products');
          await box.clear();
          await storage.deleteAll();

          // ignore: use_build_context_synchronously
          CustomSnackBar.show(
            context,
            'Error',
            'Unauthorized',
            AppColors.errorColor, // Custom background color
            Icons.error_rounded, // Custom icon
            AppColors.errorColor, // Custom icon color
          );
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        // ignore: use_build_context_synchronously
        CustomSnackBar.show(
          context,
          'Error',
          'Something went wrong',
          AppColors.errorColor, // Custom background color
          Icons.error_rounded, // Custom icon
          AppColors.errorColor, // Custom icon color
        );
        // Access token is expired or could not be obtained, handle accordingly
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }
    } catch (e) {
      print(e);
      // ignore: use_build_context_synchronously
      final snackBar = buildErrorSnackBar(context, e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getHomeScreeData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<Box<dynamic>>(
        valueListenable: Hive.box('products').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.secondaryColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          } else {
            final products = box.get('products') as Products;
            String firstname = products.firstname;
            String lastname = products.lastname;
            String email = products.email;

            final productsdatas = products.productDatas;
            // final remainingdays =
            //     dateConverter.remainingdays(comingpickups!.upcomingPickup);

            return Scaffold(
              backgroundColor: AppColors.secondaryColor,
              drawer: DrawerPage(
                  firstname: firstname, lastname: lastname, email: email),
              appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Hi $firstname',
                    style: AppFonts.poppinsBold
                        .copyWith(fontSize: AppFonts.largeFontSize),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: deviceWidth * 0.02),
                      child: IconButton(
                          splashRadius: 20,
                          onPressed: () {},
                          icon: Image.asset('assets/notification.png',
                              height: deviceHeight * 0.028,
                              width: deviceWidth * 0.2,
                              color: AppColors.planeColor)),
                    ),
                  ]),
              body: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: deviceHeight * 0.02,
                                left: deviceWidth * 0.03),
                            height: deviceHeight * 0.22,
                            width: deviceWidth * 0.42,
                            decoration: BoxDecoration(
                              color: AppColors.planeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: deviceWidth * 0.04,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Remainig Days',
                                        style: AppFonts
                                            .poppinsLightMediumsnackBar
                                            .copyWith(
                                          fontSize: AppFonts.smallFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.01,
                                ),
                                // CircularPercentIndicator(
                                //   radius: 50.0,
                                //   lineWidth: 8,
                                //   percent: 1 / remainingdays,
                                //   center: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         remainingdays.toString(),
                                //         style: AppFonts.poppinsBold.copyWith(
                                //           fontSize: AppFonts.largeFontSize,
                                //         ),
                                //       ),
                                //       Text(
                                //         'Days',
                                //         style: AppFonts.poppinsRegular.copyWith(
                                //           fontSize: AppFonts.smallFontSize,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                //   progressColor: Colors.orangeAccent,
                                // ),
                                SizedBox(
                                  height: deviceHeight * 0.015,
                                ),
                                Container(
                                  height: deviceHeight * 0.04,
                                  width: deviceWidth,
                                  margin: EdgeInsets.only(
                                    left: deviceWidth * 0.04,
                                    right: deviceWidth * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    onPressed: () async {},
                                    child: Text(
                                      'View',
                                      style: AppFonts.poppinsMedium.copyWith(
                                        fontSize: AppFonts.mediumFontSize,
                                        color: AppColors.planeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.015,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: deviceWidth * 0.03,
                          right: deviceWidth * 0.04,
                        ),
                        height: deviceHeight * 0.03,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  ' Current Services',
                                  style: AppFonts.poppinsMedium.copyWith(
                                    fontSize: AppFonts.mediumFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.87,
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: deviceWidth * 0.03,
                            right: deviceWidth * 0.03,
                            top: deviceHeight * 0.02,
                            bottom: deviceHeight * 0.02,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.isdatepicked = false;
                              controller.ispriceChange = false;
                              showModalBottomSheet(
                                backgroundColor: AppColors.secondaryColor,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                context: context,
                                builder: (context) => ProductDetail(
                                  image: images[index],
                                  id: productsdatas[index].id,
                                  price: productsdatas[index].price,
                                  name: productsdatas[index].name,
                                  plan: productsdatas[index].plan,
                                  email: email,
                                ),
                              );
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              elevation: 0.5,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          images[index],
                                        ),
                                        Positioned(
                                          top: 3,
                                          left: 6,
                                          child: Container(
                                            height: 35,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '\$${productsdatas[index].price.toString()}',
                                              style: AppFonts.poppinsMedium
                                                  .copyWith(
                                                color: AppColors.primaryColor,
                                                fontSize:
                                                    AppFonts.smallFontSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: deviceHeight * 0.02,
                                        top: deviceHeight * 0.02,
                                        right: deviceHeight * 0.02,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.planeColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  productsdatas[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppFonts
                                                      .poppinsLightMediumsnackBar
                                                      .copyWith(
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                productsdatas[index].plan,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFonts.poppinsMedium
                                                    .copyWith(
                                                  fontSize:
                                                      AppFonts.smallFontSize,
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.9),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: productsdatas.length,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
