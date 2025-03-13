import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easybiz_mobile/settings.dart';
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'cart_summary.dart';
import 'home.dart';
import 'notifications.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({super.key});

  @override
  CustomerOrdersState createState() => CustomerOrdersState();
}

class CustomerOrdersState extends State<CustomerOrders> {


  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List ordersDataList = [];

  @override
  void initState() {
    _getAllOrderByToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 2,
          height: 60.0,
          items: <Widget>[

            GestureDetector(
              child: const Icon(Icons.home, size: 30,color: Colors.white,),
              onTap: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Home())
                )

              },
            ),

            GestureDetector(
              child: const Icon(Icons.shopping_cart, size: 30, color: Colors.white),
              onTap: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CartSummary())
                )

              },
            ),

            GestureDetector(
              child: const Icon(Icons.list_alt_rounded, size: 30, color: Colors.white,),
              onTap: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CustomerOrders())
                )

              },
            ),

            GestureDetector(
              child: const Icon(Icons.settings, size: 30, color: Colors.white,),
              onTap: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Settings())
                )

              },
            ),



            GestureDetector(
              child: const Icon(Icons.notifications_active, size: 30, color: Colors.white),
              onTap: () => {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Notifications())
                )

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

              print("**********");
              print(index);

            });
          },
          letIndexChange: (index) => true,
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 40,
                    left: 12
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back,color: Colors.black,),
                      ],
                    ),
                  ],
                ),
              )
          ),


          const Align(
            alignment: Alignment.center,
            child: Text(
              'Meine Bestellungen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),

            ),
          ),


        Expanded(
        child: ListView.builder(
        itemCount: ordersDataList.length,
        itemBuilder: (BuildContext context, int index) {

          String formattedDate = '';
          String bookingTime = '';
          String totalOrderAmount = '';
          String subServiceImage = '';
          if(ordersDataList[index]['orderdata'].length!=0)
          {
              formattedDate = (ordersDataList[index]['orderdata'][0]['booking_date']).substring(0,(ordersDataList[index]['orderdata'][0]['booking_date']).length - 12);
              bookingTime = '${ordersDataList[index]['opens_at']} - ${ordersDataList[index]['closes_at']}';
              totalOrderAmount = ordersDataList[index]['total'];
              subServiceImage = ordersDataList[index]['orderdata'][0]['image_name'];
          }

          /*print("+++++++++");
          print(ordersDataList[index]['orderdata']);
          print(ordersDataList[index]['orderdata'].length);
          print("+++++++++"); */

          return Container(
            padding: const EdgeInsets.only(left:15, right: 15),
            constraints: const BoxConstraints(minHeight: 0, maxHeight: 400.0),
            child: Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top:15,left: 15),
                      child: Text('Order Id : #'+ordersDataList[index]['order_number'],
                          style: const TextStyle(
                            color: Color(0xFF252523),
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                          )
                      ),
                    ),

                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 15,
                            bottom: 15
                        ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            child: Image(
                              image: AssetImage('assets/images/easybiz_logo.png'),
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(padding: const EdgeInsets.only(left: 170),
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFF3C9),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Call Vendor',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF1F1F1F),
                                        fontSize: 12,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w700,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        )
                      ],
                    ),


                    Padding(padding: const EdgeInsets.only(top:8,left: 15),
                      child: Text((ordersDataList[index]['orderdata']).length!= 0 ? ordersDataList[index]['orderdata'][0]['vendor_name'] : 'No Vendor',
                          style: const TextStyle(
                            color: Color(0xFF252523),
                            fontSize: 16,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0.07,
                          )
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const DottedLine(),

                    Padding(padding: const EdgeInsets.only(
                        top: 15
                    ),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                            child: CachedNetworkImage(
                                height: 90,
                                fit: BoxFit.cover,
                                imageUrl: '$baseurl/subservices/$subServiceImage',
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error)
                            ),
                          ),
                        ),
                        title: Text(
                          (ordersDataList[index]['orderdata']).length!= 0 ? ordersDataList[index]['orderdata'][0]['sub_service'] : "No Data",
                          style: const TextStyle(
                              color: Color(0xFF161616),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        subtitle: Text((ordersDataList[index]['orderdata']).length!= 0 ? " € ${ordersDataList[index]['orderdata'][0]['price']}" : "No Data",), // \u2605 \u2605 \u2605 \u2605 \u2606
                      ),
                    ),

                    Padding(padding: const EdgeInsets.only(
                        left: 15,
                        top: 8
                    ),
                      child: Text(
                        'Grand Total : $totalOrderAmount',
                        style: const TextStyle(
                          color: Color(0xFF161616),
                          fontSize: 14,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),


                    Padding(padding: const EdgeInsets.only(top: 12,left: 15),
                        child: Text(
                          'B Date. $formattedDate | Slot : $bookingTime',
                          style: const TextStyle(
                            color: Color(0xFF161616),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        )
                    ),

                    Padding(padding: const EdgeInsets.only(top: 15,left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          const Icon(Icons.star_border,
                            size: 30,
                            color: Colors.orange,
                          ),

                          const Icon(Icons.star_border,
                            size: 30,
                            color: Colors.orange,
                          ),

                          const Icon(Icons.star_border,
                            size: 30,
                            color: Colors.orange,
                          ),

                          const Icon(Icons.star_border,
                            size: 30,
                            color: Colors.orange,
                          ),

                          const Icon(Icons.star_border,
                            size: 30,
                          ),


                          const Text(" | ", style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey
                          ),),

                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFF3C9),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Close Order / Comments',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1F1F1F),
                                    fontSize: 12,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),
                    ),

                  ],
                )

            ),
          );

        })
        )

        ],
      ),

    );
  }

  _getAllOrderByToken() async {

    String? userToken = await storage.read(key: 'userToken');
    String? userEmail = await storage.read(key: 'loggedEmail');

    final response = await http.get(
        Uri.parse('$baseurl/home/my-orders/$userToken/$userEmail')
    );

    var myOrdersData = jsonDecode(response.body);

    print(myOrdersData);

    setState(() {
      ordersDataList.clear();
    });

    for(final data in myOrdersData)
    {
        ordersDataList.add(data);
    }

  }

}

