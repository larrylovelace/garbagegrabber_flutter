import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garbage_grabber/models/products.dart';

import 'package:garbage_grabber/pages/home/product_detail.dart';

import 'package:garbage_grabber/utils/colors.dart';

import 'package:garbage_grabber/utils/fonts.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:intl/intl.dart';

import '../../controllers/apihandler.dart';
import '../../controllers/homescreen_controller.dart';
import '../../controllers/routes.dart';
import '../../controllers/token_manager.dart';

import 'package:http/http.dart ' as http;

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

  List<String> images = [
    'assets/Onebag.png',
    'assets/Twobag.png',
    'assets/Onebag.png',
    'assets/Twobag.png',
  ];

  Future<void> getProductdetails() async {
    try {
      final refreshToken = await storage.read(key: 'refreshtoken');

      final tokenManager = TokenManager();

      String? accessToken = await tokenManager.checkTokensAndRequestAccessToken(
          refreshToken!, APIConstants.tokenRefresh);

      if (accessToken != null) {
        String uri = APIConstants.baseURI + APIConstants.productdetails;

        var response = await http.get(Uri.parse(uri), headers: {
          'Authorization': 'Bearer $accessToken',
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          email = data['profile_details']['email'];

          // Store product details in Hive

          final productsBox = Hive.box('products');

          final products = Products(
            firstname: data['profile_details']['first_name'],
            lastname: data['profile_details']['last_name'],
            email: data['profile_details']['email'],
            totalpayment: data['profile_details']['total_payment'] ?? 0,
            productDatas: List<ProductData>.from(data['products'].map((item) {
              return ProductData(
                id: item['id'],
                name: item['name'],
                price: item['price'].toDouble(),
                plan: item['plan'],
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
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    getProductdetails();
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

            return Scaffold(
                backgroundColor: AppColors.secondaryColor,
                drawer: DrawerPage(
                    firstname: firstname, lastname: lastname, email: email),
                appBar: AppBar(
                    toolbarHeight: 40,
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    leading: Builder(builder: (context) {
                      return IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: SvgPicture.asset(
                            'assets/menu.svg',
                          ));
                    }),
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
                body: Column(
                  children: <Widget>[
                    HeaderwithSearch(
                      deviceWidth: deviceWidth,
                      deviceHeight: deviceHeight,
                      firstname: products.firstname,
                      totalpayment: products.totalpayment.toStringAsFixed(2),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.04, right: deviceWidth * 0.04),
                      height: deviceHeight * 0.04,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Text(
                                'Services',
                                style: AppFonts.poppinsMedium
                                    .copyWith(fontSize: AppFonts.largeFontSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productsdatas.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.84, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.03,
                                right: deviceWidth * 0.03,
                                top: deviceHeight * 0.02,
                                bottom: deviceHeight * 0.02),
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
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 0.5,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '\$${productsdatas[index].price.toString()}',
                                                style: AppFonts.poppinsMedium
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: AppFonts
                                                            .smallFontSize),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: deviceHeight * 0.02,
                                            top: deviceHeight * 0.02,
                                            right: deviceHeight * 0.02),
                                        decoration: BoxDecoration(
                                          color: AppColors.planeColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
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
                                                        .poppinsMedium
                                                        .copyWith(
                                                            fontSize: AppFonts
                                                                .smallFontSize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  productsdatas[index].plan,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppFonts
                                                      .poppinsLightMediumsnackBar
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor
                                                              .withOpacity(
                                                                  0.9)),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ));
          }
        });
  }
}

class HeaderwithSearch extends StatelessWidget {
  const HeaderwithSearch({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.firstname,
    required this.totalpayment,
  });

  final double deviceWidth;
  final double deviceHeight;
  final String firstname;
  final String totalpayment;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);

    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.16,
      margin: EdgeInsets.only(bottom: deviceHeight * 0.03),
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.04,
              right: deviceWidth * 0.04,
              bottom: deviceWidth * 0.1),
          height: deviceHeight * 0.13,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Hi $firstname!',
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppinsBold.copyWith(
                          fontSize: AppFonts.largeFontSize,
                          color: AppColors.planeColor),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      formattedDate,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.poppinsRegular
                          .copyWith(color: AppColors.planeColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
                height: deviceHeight * 0.09,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: deviceWidth * 0.41,
                          child: Card(
                            color: AppColors.planeColor,
                            elevation: 0.5,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {
                                Get.toNamed(AppRoutes.transactions);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.payment_outlined,
                                        size: 20,
                                        color: AppColors.iconColor,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.01,
                                      ),
                                      Text(
                                        'Transactions',
                                        style: AppFonts.poppinsMedium.copyWith(
                                            color: AppColors.cancelColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '\$$totalpayment',
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.poppinsBold
                                              .copyWith(
                                                  fontSize:
                                                      AppFonts.mediumFontSize)
                                              .copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.41,
                          child: Card(
                            color: AppColors.planeColor,
                            elevation: 0.5,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                        color: AppColors.iconColor,
                                      ),
                                      SizedBox(
                                        width: deviceWidth * 0.01,
                                      ),
                                      Text(
                                        'Pickup Date',
                                        style: AppFonts.poppinsMedium.copyWith(
                                            color: AppColors.cancelColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'July-05',
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.poppinsMedium
                                              .copyWith(
                                                  fontSize:
                                                      AppFonts.mediumFontSize)
                                              .copyWith(
                                                  color: AppColors.iconColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
