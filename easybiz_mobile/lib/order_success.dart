import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'my_orders.dart';

class OrderSuccessFail extends StatefulWidget {
  const OrderSuccessFail({super.key});

  @override
  OrderSuccessFailState createState() => OrderSuccessFailState();
}

class OrderSuccessFailState extends State<OrderSuccessFail> {

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String vendorName = '';
  String orderId = '';
  String subServiceName = '';
  String bookingDate = '';
  String bookingSlot = '';
  String totalAmount = '';

  @override
  void initState() {

    _getAllOrderDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 55
                ),
                child: Image.asset(
                  "assets/images/success.png",
                  height: 100,
                  width: 100,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 10,bottom: 5),
              child: Text(" Thank You ",style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),)
            ),

            const Padding(
                padding: EdgeInsets.only(top: 5,bottom: 10),
                child: Text("Your Service Order Request has been received",style: TextStyle(
                    fontSize: 16
                ),)
            ),

            const Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Text("You will receive your invoice via email",style: TextStyle(
                    fontSize: 14
                ),)
            ),

            Container(
              width: 200,
              height: 40,
              color: const Color(0xffe6ffe1),
              child: const Padding(
                  padding: EdgeInsets.only(left:20,top: 10,bottom: 10),
                  child: Text("Order sent to Vendor",style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),)
              ),
            ),



            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left:15, right: 15),
                constraints: const BoxConstraints(minHeight: 0, maxHeight: 250.0),
                child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top:10,left: 15,right: 15),child: Text(
                          'Order Details',
                          style: TextStyle(
                              color: Color(0xFF161616),
                              fontSize: 18,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        const DottedLine(),
                        const SizedBox(
                          height: 10,
                        ),

                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Order Id',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                orderId,
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Vendor',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                vendorName,
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Service',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                subServiceName,
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Booked Date',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                bookingDate,
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Booked Time Slot',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                bookingSlot,
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),


                        Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                          child: Row(
                            children: [
                              const Text(
                                'Amount',
                                style: TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),

                              const Spacer(),

                              Text(
                                '€ $totalAmount',
                                style: const TextStyle(
                                    color: Color(0xFF161616),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )

                )
            ),

            Padding(padding: const EdgeInsets.only(top:15,left: 15,right: 15),
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerOrders()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFED130),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      )
                  ),
                  child: const Center(
                    child: Text('Okay',style: TextStyle(
                      color: Color(0xFF060606),
                      fontSize: 15,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    )
                    ),
                  ),
                )
            )

          ],
        )
    );

  }

  _getAllOrderDetails() async {

      String? userToken = await storage.read(key: 'userToken');
      String? encOrderId = await storage.read(key: 'encOrderId');
      String? userEmail = await storage.read(key: 'loggedEmail');

      final response = await http.get(
          Uri.parse('$baseurl/orders-success/$encOrderId/$userToken/$userEmail')
      );

      print(response.body);

      var orderDetails = jsonDecode(response.body);

      setState(() {
        vendorName = orderDetails['vendorName'];
        orderId = orderDetails['orderId'];
        subServiceName = orderDetails['subServiceName'];
        bookingDate = orderDetails['bookingDate'];
        bookingSlot = orderDetails['bookingSlot'];
        totalAmount = orderDetails['totalAmount'];
      });

  }


}