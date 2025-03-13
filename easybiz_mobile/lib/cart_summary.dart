import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'home.dart';
import 'order_success.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;

class CartSummary extends StatefulWidget {
  const CartSummary({super.key});

  @override
  CartSummaryState createState() => CartSummaryState();
}

class CartSummaryState extends State<CartSummary> {

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Map<String, dynamic>? paymentIntent;

  String vendorName = '';
  String vendorLogo = '';
  String subserviceImage = '';
  String subServiceName = '';
  String subServicePrice = '';
  String bookedDate = '';
  String fromtimeSlot = '';
  String totimeSlot = '';

  @override
  void initState() {
    _getOrderDetailsBySessionId();
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey = "pk_test_51MJnsyDNh0Sp9L0KqvSu8pOcI3SD8EefIEL7tciz7pBJjMxxaC3ueOZq1cTJuRkjmAZfalyvdoLZMPpxp3dT5sRm00ivv9zfxa";
    Stripe.instance.applySettings();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: vendorName!= '' ? <Widget>[
          SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 60,
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
               'Bestellübersicht',
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 25,
                 fontFamily: 'DM Sans',
                 fontWeight: FontWeight.w700,
               ),

             ),
           ),


          const Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top:15),
              child :Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  'Selected Vendor',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),)
          ),

          Container(
            padding: const EdgeInsets.only(left:15, right: 15),
            constraints: const BoxConstraints(minHeight: 0, maxHeight: 170.0),
            child: Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    children: [
                      Padding(padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                          bottom: 15
                      ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          child: CachedNetworkImage(
                              height: 80,
                              fit: BoxFit.cover,
                              imageUrl: '$baseurl/vendor-logo/$vendorLogo',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error)
                          ),
                        ),
                      ),

                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(padding: const EdgeInsets.only(left: 150),
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
                                    'Change vendor ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      fontSize: 12,
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.w700,
                                      height: 0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(top:8,left: 15),
                        child: Text(vendorName,
                            style: const TextStyle(
                              color: Color(0xFF252523),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              height: 0.07,
                            )
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 12,left: 15),
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
                                text: ' 4.83 (18 Reviews)',
                                style: TextStyle(
                                  color: Color(0xFF545454),
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              TextSpan(
                                text: ' \u2714 ',
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              TextSpan(
                                text: '30 orders completed',
                                style: TextStyle(
                                  color: Color(0xFF545454),
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              )

                            ],
                          ),
                        ),
                      )
                    ],
                  )

                ],
                )

            ),
          ),

          const Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top:15),
              child :Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  'Package Chosen',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: AspectRatio(

                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: '$baseurl/subservices/$subserviceImage',
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error)
                      ),
                    ),
                  ),
                  title: Text(
                    subServiceName,
                    style: const TextStyle(
                      color: Color(0xFF161616),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500
                    ),
                  )

                  ,
                  subtitle: Text('€ $subServicePrice'), // \u2605 \u2605 \u2605 \u2605 \u2606
                  trailing: GestureDetector(child: const Image(image: AssetImage('assets/images/delete.png'),
                    width: 50
                    ,) ,onTap: () => {

                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Padding(padding: EdgeInsets.only(top:10),child: Text(
                                  'Sure you want to change the Package ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child : Center(
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                //shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
                                                side: WidgetStateProperty.resolveWith<BorderSide>(
                                                        (Set<WidgetState> states) {
                                                      final Color color = states.contains(WidgetState.pressed)
                                                          ? Colors.blue
                                                          : Colors.red;
                                                      return BorderSide(color: color, width: 2);
                                                    }
                                                ),
                                              ),
                                              onPressed: () {


                                              },
                                              child: const Text('No'),
                                            ),
                                          )
                                      ),

                                      const SizedBox(child: Center(
                                          child: Text('Yes')
                                      )
                                      )

                                    ],
                                  ),

                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )

                  },),
                )
            ),
          ),

          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left:15, right: 15),
              constraints: const BoxConstraints(minHeight: 0, maxHeight: 150.0),
              child: Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top:10,left: 15,right: 15),child: Text(
                        'Payment Summary',
                        style: TextStyle(
                            color: Color(0xFF161616),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      ),

                      Padding(padding: const EdgeInsets.only(top:10,left: 15,right: 15),
                        child: Row(
                          children: [
                            const Text(
                              'Item Total',
                              style: TextStyle(
                                  color: Color(0xFF161616),
                                  fontSize: 14,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400
                              ),
                            ),

                            const Spacer(),

                            Text(
                              '€ $subServicePrice',
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

                      const SizedBox(
                        height: 10,
                      ),
                      const DottedLine(),
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(padding: const EdgeInsets.only(top:5,left: 15,right: 15),
                        child: Row(
                          children: [
                            const Text(
                              'Grand Total',
                              style: TextStyle(
                                color: Color(0xFF161616),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              '€ $subServicePrice',
                              style: const TextStyle(
                                color: Color(0xFF161616),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  )

              )
          ),

          /*const Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: Icon(Icons.pin_drop_outlined),
                    ),
                  ),
                  title: Text('Service request at Home',style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  )),
                  subtitle: Text("Frankfurt, Germany"),
                  trailing: Icon(Icons.edit),
                )
            ),
          ), */

          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: const AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: Icon(Icons.access_time),
                    ),
                  ),
                  title: Text('$bookedDate : $fromtimeSlot - $totimeSlot Hrs',style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  )),
                  subtitle: const Text("Booking Time Slot"),
                  //trailing: const Icon(Icons.edit),
                )
            ),
          ),

          Padding(padding: const EdgeInsets.only(
                  top: 25,
                  left: 15,
                  right: 15
              ),
              child: SwipeButton(
                borderRadius: BorderRadius.circular(8),
                activeThumbColor: const Color(0xFFFED130),
                height: 65,
                thumbPadding: const EdgeInsets.all(3),
                activeTrackColor: Colors.black,
                thumb:  const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                elevationThumb: 2,
                elevationTrack: 2,

                child: Text(
                  "Swipe To Pay".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onSwipe: () async {

                  await makePayment(subServicePrice);

                  //_placeOrder();

                  /*ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Proceeding To Payment Partner"),
                      backgroundColor: Colors.black,
                    ),
                  ); */
                },
              ),
          )

        ] : <Widget>[

          SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 60,
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
              'Bestellübersicht',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),

            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 200
                  ),
                  child: Image.asset(
                    "assets/images/empty-cart.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),

              const Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 5),
                  child: Text(" Einkaufswagen ist leer ",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)
              ),

              const Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 10),
                  child: Text("Klicken Sie auf 'Home', um Services bei uns zu bestellen"
,style: TextStyle(
                      fontSize: 16
                  ),)
              ),

              Padding(
                  padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const Home())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(60), // Set height to 10dp
                          fixedSize: const Size.fromWidth(double.infinity), // Set full width
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Square border
                            side: const BorderSide(color: Colors.black), // Optional: black border
                          )
                      ),
                      child: const Text(' Service bestellen ',style: TextStyle(color: Colors.white, fontSize: 20),)
                  ),
              )

              ]
          )

        ],
      ),
    );
  }

  _getOrderDetailsBySessionId() async
  {
      String? sessionId = await storage.read(key: 'userSession');
      final cartResponse = await http.get(
          Uri.parse('$baseurl/home/services/cart-detail/$sessionId')
      );

      var cartDetails = jsonDecode(cartResponse.body);

      print(cartDetails);

      setState(() {
          vendorName = cartDetails['vendordata'][0]['company_name'];
          vendorLogo = cartDetails['vendordata'][0]['company_logo'];
          subserviceImage = cartDetails['jsondata'][0]['image'];
          subServiceName = cartDetails['jsondata'][0]['serviceName'];
          subServicePrice = cartDetails['jsondata'][0]['price'];
          bookedDate = cartDetails['jsondata'][0]['booked_date'];
          fromtimeSlot = cartDetails['jsondata'][0]['slot_from'];
          totimeSlot = cartDetails['jsondata'][0]['slot_to'];
      });

  }

  _placeOrder() async
  {
      String? userToken = await storage.read(key: 'userToken');
      String? sessionId = await storage.read(key: 'userSession');
      String? userEmail = await storage.read(key: 'loggedEmail');
      String? timeSlotId = await storage.read(key: 'timeSlotId');
      String? vendorId = await storage.read(key: 'vendorId');
      String? preferredDate = await storage.read(key: 'preferredDate');

      var parsedDate = DateTime.parse(preferredDate!);
      var fullDateFormat = DateFormat('dd-MM-yyyy');
      String fullDate = fullDateFormat.format(parsedDate);

      final map = <String, dynamic>{};
      map['user_token'] = userToken;
      map['loggedin-email'] = userEmail;
      map['session_id'] = sessionId;
      map['booked_date'] = fullDate;
      map['booked_slot'] = timeSlotId;
      map['vendor_id'] = vendorId;

      final response = await http.post(
        Uri.parse('$baseurl/home/order/generate'),
        body: map,
      );

      //print(response.body);

      var orderStatusResponse = jsonDecode(response.body);

      if(context.mounted)
      {
          if(orderStatusResponse['errflag'] == 0)
          {
              storage.write(
                  key: 'encOrderId',
                  value: orderStatusResponse['order_id']
              );

              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderSuccessFail()));
          }
          else
          {
              const snackBar = SnackBar(
                content: Text('Order Not Placed'),
                showCloseIcon: true,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      }
  }

  Future<void> makePayment(subServicePriceValue) async {

    var subServicePrice = subServicePriceValue.split('.');

    try {
      paymentIntent = await createPaymentIntent(subServicePrice[0], 'EUR');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'Easybiz'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {

      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));

            _placeOrder();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Zahlung fehlgeschlagen"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {

    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51MJnsyDNh0Sp9L0K6h9CepbO7e6UmbnWiXL0SavBKixD8fhaPdfnOrTAEUDxHGmXpRgjRddLHMU1A33bGdzPHuYP00wz2BS1T6',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

}

