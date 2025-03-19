import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easybiz_mobile/settings.dart';
import 'package:easybiz_mobile/vendor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:readmore/readmore.dart';

import 'cart_summary.dart';
import 'home.dart';
import 'my_orders.dart';
import 'notifications.dart';

class Vendors extends StatefulWidget {
  const Vendors({super.key});

  @override
  VendorsPackagesState createState() => VendorsPackagesState();
}

class VendorsPackagesState extends State<Vendors> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List vendorsDataList = [];

  List pincodeData = [];
  String pincodeNumber = '';
  String subServiceDisplayName = '';

  @override
  void initState() {
    _getVendorDetails();
  }

  List<DropdownMenuItem<String>> dropDownItems = [
    const DropdownMenuItem(
      value: '1',
      child: Row(
        children: [
          Text('Hoch zu niedrig'),
        ],
      ),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Row(
        children: [
          Text('Niedrig zu hoch'),
        ],
      ),
    ),
  ];

  String _selectedValue = '1';
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 3,
          height: 60.0,
          items: <Widget>[
            GestureDetector(
              child: const Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()))
              },
            ),
            GestureDetector(
              child: const Icon(Icons.shopping_cart,
                  size: 30, color: Colors.white),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartSummary()))
              },
            ),
            GestureDetector(
              child: const Icon(
                Icons.list_alt_rounded,
                size: 30,
                color: Colors.white,
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CustomerOrders()))
              },
            ),
            GestureDetector(
              child: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.white,
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Settings()))
              },
            ),
            GestureDetector(
              child: const Icon(Icons.notifications_active,
                  size: 30, color: Colors.white),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Notifications()))
              },
            ),
          ],
          color: Colors.black,
          buttonBackgroundColor: const Color(0xFFFED130),
          backgroundColor: Colors.white,
          //animationCurve: Curves.easeInOut,
          //animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;

              print("**********");
              print(index);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: const Padding(
                  padding: EdgeInsets.only(top: 60, left: 12),
                  child: Text(
                    'Anbieter auswählen',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400),
                  ),
                )),

            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
              child: Text(
                'Selected Package : $subServiceDisplayName',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            //
            const Padding(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nach Preis sortieren',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0F0F0F),
                      fontSize: 15,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
                child: DropdownButtonFormField(
                  value: _selectedValue,
                  items: dropDownItems,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue = newValue as String;
                      _ascendingDataSort(_selectedValue);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF0F0F0F), width: 1.0),
                    ),
                  ),
                )),

            Expanded(
              child: ListView.builder(
                  itemCount: vendorsDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 280,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vendorsDataList[index]['company_name']
                                          .toString(),
                                      style: const TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 18,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '€ ${vendorsDataList[index]['totalPrice']} onwards ',
                                      style: const TextStyle(
                                        color: Color(0xFF545454),
                                        fontSize: 14,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '\u2605',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 14,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '4.83 (25 Reviews)',
                                              style: TextStyle(
                                                color: Color(0xFF545454),
                                                fontSize: 14,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ReadMoreText(
                                      vendorsDataList[index]['description']
                                          .toString(),
                                      trimLines: 2,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 110,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Stack(
                                  children: [
                                    Card(
                                        color: Colors.white,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                              height: 100,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  '$baseurl/vendor-logo/' +
                                                      vendorsDataList[index]
                                                          ['company_logo'],
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error)),
                                        )),
                                    Positioned(
                                        left: 20,
                                        top: 80,
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        VendorsDetails(
                                                            vendorId:
                                                                vendorsDataList[
                                                                        index]
                                                                    ['id'])))
                                          },
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFFFFF3C9),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFFED130)),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Choose',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFF1F1F1F),
                                                      fontSize: 12,
                                                      fontFamily: 'Segoe UI',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Divider(),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ));
  }

  _getVendorDetails() async {
    String? sessionId = await storage.read(key: 'userSession');
    String? pincode = await storage.read(key: 'pincode');
    String? numbersOnly = pincode?.replaceAll(RegExp(r'\D'), ''); 

    String? subserviceNameFS = await storage.read(key: 'subServiceName');
    String? nearPincodes = await storage.read(key: 'nearest_pincodes');
      List<String> pincodeList = List<String>.from(jsonDecode(nearPincodes!));
      String formattedPincodes = pincodeList.join('|');

    // print("*******");
    // print(sessionId);
    // print(numbersOnly);
    // print(nearPincodes);
    //   print(formattedPincodes);
    // print("***pincode and sessionId**");

    // if (pincode != null) {
    //   pincodeData = pincode.split(' - ');
    //   pincodeNumber = pincodeData[0];
    // } else {
    //   pincodeNumber = '';
    // }

    final response = await http.get(
        Uri.parse('$baseurl/home/services/vendors/$sessionId/$numbersOnly|$formattedPincodes/163'));

    print("Vendor Details +++++++");
    print(response.body);
    Map<String, String> allValues = await storage.readAll();
    print(allValues);
    print("Vendor Details +++++++");

    var vendorDataJson = jsonDecode(response.body);

    setState(() {
      vendorsDataList.clear();
      subServiceDisplayName = subserviceNameFS!;
    });

    for (final data in vendorDataJson['jsondata']) {
      vendorsDataList.add(data);
    }
  }

  _ascendingDataSort(String sortFlag) {
    if (sortFlag == '2') {
      setState(() {
        ascBubbleSort(vendorsDataList);
      });
    } else if (sortFlag == '1') {
      setState(() {
        descBubbleSort(vendorsDataList);
      });
    }
  }

  void ascBubbleSort(List list) {
    //list is an array of your Object
    //example > List unitList = [unit1,unit2,unit3];
    if (list.isEmpty) return;

    int n = list.length;
    int i, step;
    for (step = 0; step < n; step++) {
      for (i = 0; i < n - step - 1; i++) {
        if (double.parse(list[i]['totalPrice']) >
            double.parse(list[i + 1]['totalPrice'])) {
          //if(list[i].unit_no > list[i + 1].unit_no){
          swap(list, i);
          //}
        }
      }
    }
  }

  void descBubbleSort(List list) {
    //list is an array of your Object
    //example > List unitList = [unit1,unit2,unit3];
    if (list.isEmpty) return;

    int n = list.length;
    int i, step;
    for (step = 0; step < n; step++) {
      for (i = 0; i < n - step - 1; i++) {
        if (double.parse(list[i]['totalPrice']) <
            double.parse(list[i + 1]['totalPrice'])) {
          //if(list[i].unit_no > list[i + 1].unit_no){
          swap(list, i);
          //}
        }
      }
    }
  }

  void swap(List list, int i) {
    var temp = list[i];
    list[i] = list[i + 1];
    list[i + 1] = temp;
  }
}
