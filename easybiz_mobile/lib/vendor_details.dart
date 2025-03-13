import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'make_payment.dart';

class VendorsDetails extends StatefulWidget {
  final int vendorId;
  const VendorsDetails({super.key,required this.vendorId});

  @override
  VendorsDetailsState createState() => VendorsDetailsState();
}

class VendorsDetailsState extends State<VendorsDetails> {

  late ValueNotifier<int> _counter;
  final selectedColor = 0xFFFFF9E5;
  bool colorFlag = false;
  List cartList = [];
  String errorMessageDateTimeSlots = '';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String vendorName = 'No vendor selected';
  String vendorDescription = '';
  String vendorLogo = '';
  String subServiceName = '';
  String subServiceDescription = '';
  String subServiceImage = '';
  int keyData = 0;
  int noOfImages = 3;
  final datesTimeSlots = <Widget>[];
  final timeSlots = <Widget>[Container(
    decoration: ShapeDecoration(
      color: const Color(0xFFFFF9E5),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFFED130)),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Please Select a Date',
        style: TextStyle(
          color: Color(0xFF161616),
          fontSize: 14,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),

  )];

  List<String> vendorGalleryImages = ["https://miro.medium.com/v2/resize:fit:1358/1*jJKlUDkGzezjiFPagzvnuw.gif",
    "https://miro.medium.com/v2/resize:fit:1358/1*jJKlUDkGzezjiFPagzvnuw.gif"
    ,"https://miro.medium.com/v2/resize:fit:1358/1*jJKlUDkGzezjiFPagzvnuw.gif"];

  @override
  void initState() {
    _getVendorDetails(widget.vendorId);
    _counter = ValueNotifier<int>(0);
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
        child: ElevatedButton(

          onPressed: () {

            showModalBottomSheet<dynamic>(
              //isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    SizedBox(
                      height: 350,
                      child: Center(
                        child:

                        ValueListenableBuilder(
                          valueListenable: _counter,
                          builder: (context, value, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 10), child: Text(
                                'Select Date and Time',
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
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: datesTimeSlots /*[

                                Container(
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFF9E5),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                      Text(
                                        'Sat',
                                        style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '10',
                                        style: TextStyle(
                                          color: Color(0xFF161616),
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )

                                    ],),
                                  ),

                                ),

                                const Spacer(),

                                Container(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: [
                                      Text(
                                        'Sun',
                                        style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '11',
                                        style: TextStyle(
                                          color: Color(0xFF161616),
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )

                                    ],),
                                  ),

                                ),

                                const Spacer(),

                                Container(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: [
                                      Text(
                                        'Mon',
                                        style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '12',
                                        style: TextStyle(
                                          color: Color(0xFF161616),
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )

                                    ],),
                                  ),

                                ),

                                const Spacer(),

                                Container(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: [
                                      Text(
                                        'Tue',
                                        style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '13',
                                        style: TextStyle(
                                          color: Color(0xFF161616),
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )

                                    ],),
                                  ),

                                ),

                                const Spacer(),

                                Container(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: [
                                      Text(
                                        'Wed',
                                        style: TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '14',
                                        style: TextStyle(
                                          color: Color(0xFF161616),
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )

                                    ],),
                                  ),

                                )

                              ] */,
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              Padding(padding: const EdgeInsets.only(
                                  left: 15, right: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  key: ValueKey(Random().nextInt(100)),
                                  children: timeSlots,
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),


                              Padding(padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Text(errorMessageDateTimeSlots,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500,
                                      )
                                  ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              Padding(padding: const EdgeInsets.only(
                                  left: 15, right: 15), child: ElevatedButton(
                                  onPressed: () {
                                      _addToCart();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFED130),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // <-- Radius
                                      )
                                  ),
                                  child: const Center(
                                    child: Text(
                                        'Book This Time Slot', style: TextStyle(
                                      color: Color(0xFF060606),
                                      fontSize: 15,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    )
                                    ),
                                  ),
                              ),)



                            ],
                          ),
                        )


                      ),
                    )
                  ],
                );



              },
            );

            /*Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CartSummary())
            ); */

          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFED130),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              )
          ),

          child: const Center(
            child: Text('Choose Date and Time',style: TextStyle(
              color: Color(0xFF060606),
              fontSize: 15,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            )
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 50,
                    left: 12
                ),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back),
                      ],
                    ),
                  ],
                ),
              )
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Card(
                    //clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: CachedNetworkImage(
                            height: 100,
                            fit: BoxFit.cover,
                            imageUrl: '$baseurl/vendor-logo/$vendorLogo',
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Icon(Icons.error)
                        )

                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10 ,left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendorName.toString(),
                      style: const TextStyle(
                        color: Color(0xFF060606),
                        fontSize: 15,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // padding: const EdgeInsets.only(top:5,right: 15)
                    SizedBox(
                      width: 250,
                      child: Text(
                        vendorDescription.toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color(0xFF0F0F0F),
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    /*const Text(
                      'Price Starts From €100 ',
                      style: TextStyle(
                        color: Color(0xFF0F0F0F),
                        fontSize: 15,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ), */

                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [

                            TextSpan(
                              text: '\u2605',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 11,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            TextSpan(
                              text: '4.83 (25 Bewertungen )',
                              style: TextStyle(
                                color: Color(0xFF545454),
                                fontSize: 11,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            TextSpan(
                              text: '\u2713',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 11,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            TextSpan(
                              text: '20 Orders Completed',
                              style: TextStyle(
                                color: Color(0xFF545454),
                                fontSize: 11,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            )

                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),

          const SizedBox(
            height: 5,
          ),

          const Padding(padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
              child: Divider(),
          ),

          Row(
            children: [
              SizedBox(
                width: 280,
                child: Padding(padding: const EdgeInsets.only(left: 15,top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subServiceName.toString(),
                        style: const TextStyle(
                            color: Color(0xFF0F0F0F),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 10),
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
                                text: '4.83 (25 Bewertungen )',
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
                      const SizedBox(height: 5,),
                      Text(
                        subServiceDescription.toString(),
                        style: const TextStyle(
                          color: Color(0xFF545454),
                          fontSize: 12,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      )

                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 110,
                child: Padding(padding: const EdgeInsets.only(right: 15),
                  child: Stack(children: [
                    Card(
                        color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                              height: 90,
                              fit: BoxFit.cover,
                              imageUrl: '$baseurl/subservices/$subServiceImage',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error)
                          ),
                        )
                    ),
                    Positioned(
                        left:20,
                        top:80,
                        child: GestureDetector(onTap: ()=>{
                        },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
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
                                  'Change',
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
                          ),)
                    )

                  ],
                  ),
                ),
              ),
            ],
          ),

          const Padding(padding: EdgeInsets.only(top:5,left: 15,right: 15),child: Divider(
              color: Colors.grey
          ),),


          const Padding(padding: EdgeInsets.only(top: 10,left: 15),child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Easybiz Vendor Gallery',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),),),

          Flexible(child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: GalleryImage(
                numOfShowImages: noOfImages,
                key: ValueKey(Random().nextInt(100)),
                imageUrls: vendorGalleryImages
              )
          ),
          )

         /* SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: CarouselSlider(
                  options: CarouselOptions(height: 350,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,),
                  items: imgList.map((item) => Container(
                    child: Center(
                        child: Image.network(item, fit: BoxFit.cover, width: 1000,)),
                  )).toList()
              ),),
          ), */

        ],
      ),
    );
  }


  _getVendorDetails(int pVendorId) async {

    final response = await http.get(
        Uri.parse('$baseurl/home/services/vendor-detail/$pVendorId')
    );

    var vendorDataJson = jsonDecode(response.body);

    String? sessionId = await storage.read(key: 'userSession');

    final responseCartDetails = await http.get(
        Uri.parse('$baseurl/home/services/cart-details-session/$sessionId')
    );

    var subServiceData = jsonDecode(responseCartDetails.body);

    final responseVendorImages = await http.get(
        Uri.parse('$baseurl/vendor-gallery/public/all/$pVendorId')
    );

    var imagesData = jsonDecode(responseVendorImages.body);
    int imageDataLength = imagesData.length;
    String imageUrlData = '';

    setState(() {
      vendorName = vendorDataJson['jsondata'][0]['business_owner_name'];
      vendorDescription = vendorDataJson['jsondata'][0]['description'];
      vendorLogo = vendorDataJson['jsondata'][0]['company_logo'];
      subServiceName = subServiceData[0]['name'];
      subServiceDescription = (subServiceData[0]['description']).trim();
      subServiceImage = subServiceData[0]['image_name'];
    });

    setState(() {
      vendorGalleryImages.clear();
      noOfImages = imageDataLength;
    });

    for(var i = 0;i < imageDataLength;i++)
    {
      imageUrlData = '$baseurl/static/'+imagesData[i]['image_name'];
      vendorGalleryImages.add(imageUrlData);
    }

    // Generate next 5 Days
    setState(() {
      datesTimeSlots.clear();
    });

    for (int i = 0; i < 5; i++)
    {

      DateTime now = DateTime.now().add(Duration(days: i));
      var formatter = DateFormat('dd');
      String day = formatter.format(now);
      String dayOfWeek = DateFormat('E').format(now);

      var fullDateFormat = DateFormat('yyyy-MM-dd');
      String fullDate = fullDateFormat.format(now);

      datesTimeSlots.add(
            GestureDetector(
                onTap: () {
                  _getAllTimeSlots(pVendorId,dayOfWeek,fullDate);
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: colorFlag ? const Color(0xFFFED130) : Color(selectedColor),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          dayOfWeek.toString(),
                          style: const TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        Text(
                          (day).toString(),
                          style: const TextStyle(
                            color: Color(0xFF161616),
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ],),
                  ),

                ),
              )

        );
        datesTimeSlots.add(const Spacer());
    } // For Loop End

  }

  _getAllTimeSlots(int vendorId,String dayOfWeek,String fullDate) async {

    int dayId;
    List<String> daysOfWeek = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    dayId = daysOfWeek.indexOf(dayOfWeek) + 1;

    String? userToken = await storage.read(key: 'userToken');
    String? userEmail = await storage.read(key: 'loggedEmail');

    final vendorResponse = await http.get(
        Uri.parse('$baseurl/vendor-details/$vendorId/$dayId/$userToken/$userEmail')
    );

    var vendorTimeSlots = jsonDecode(vendorResponse.body);
    int timeSlotLength = vendorTimeSlots.length;

    print(vendorTimeSlots);

    setState(() {
      timeSlots.clear();
    });

    for(int i = 0;i < timeSlotLength;i++)
    {
        //
        timeSlots.add(
          GestureDetector(
            onTap: () => {
              _setVendorData(vendorId,vendorTimeSlots[i]['id'],fullDate)
            },
             child: Container(
               decoration: ShapeDecoration(
                 color: const Color(0xFFFFF9E5),
                 shape: RoundedRectangleBorder(
                   side: const BorderSide(width: 1, color: Color(0xFFFED130)),
                   borderRadius: BorderRadius.circular(12),
                 ),
               ),
               child: Padding(
                 padding: const EdgeInsets.all(20),
                 child: Text(
                   vendorTimeSlots[i]['opens_at']+' - '+vendorTimeSlots[i]['closes_at'],
                   style: const TextStyle(
                     color: Color(0xFF161616),
                     fontSize: 14,
                     fontFamily: 'DM Sans',
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),

             ),
          )

        );
    }

    _counter.value++;

  }


  _setVendorData(int vendorId,int timeSlotId,String fullDate) async {
      cartList.add(vendorId);
      cartList.add(timeSlotId);
      cartList.add(fullDate);
  }

  _addToCart() async {

    String? userToken = await storage.read(key: 'userToken');
    String? userEmail = await storage.read(key: 'loggedEmail');
    String? sessionId = await storage.read(key: 'userSession');

    if(context.mounted)
    {
        if (userToken == '' || userEmail == '' || sessionId == '')
        {
            const snackBar = SnackBar(
              content: Text('Something Went Wrong'),
              showCloseIcon: true,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if(cartList.isEmpty)
        {
            setState(() {
              errorMessageDateTimeSlots = 'Please select Date and Time';
            });
            return;
        }
    }

    final map = <String, dynamic>{};
    map['user_token'] = userToken;
    map['loggedin-email'] = userEmail;
    map['sessionId'] = sessionId;
    map['preferredDate'] = cartList[2].toString();
    map['slotId'] = cartList[1].toString();
    map['vendorId'] = cartList[0].toString();

    // Time Slot Id
    await storage.write(
        key: 'timeSlotId',
        value: cartList[1].toString()
    );

    // Vendor Id
    await storage.write(
        key: 'vendorId',
        value: cartList[0].toString()
    );

    // Preferred Date
    await storage.write(
        key: 'preferredDate',
        value: cartList[2].toString()
    );

    final responseData = await http.post(
      Uri.parse('$baseurl/home/services/add-cart'),
      body: map,
    );

    var jsonResponseData = jsonDecode(responseData.body);

    if(jsonResponseData['errflag'] == 0)
    {
        await storage.write(
            key: 'userSession',
            value: jsonResponseData['userSession']
        );

        if(context.mounted)
        {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => const MakePaymentTrigger())
            );
        }
    }

  }

}