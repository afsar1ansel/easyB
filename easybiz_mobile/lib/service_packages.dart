import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easybiz_mobile/urlconfig.dart';
import 'package:easybiz_mobile/vendors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

int serviceIdSp = 0;
String _selectedValue = '';
int _serviceGrpId = 0;
List subServiceGroupDataList = [];

class ServicesPackages extends StatefulWidget {
  final int serviceIdSp;
  final int serviceGroupId;
  const ServicesPackages(
      {super.key, required this.serviceIdSp, required this.serviceGroupId});

  @override
  ServicesPackagesState createState() => ServicesPackagesState();
}

class ServicesPackagesState extends State<ServicesPackages> {
  List<DropdownMenuItem<String>> dropDownItemsSp = [];
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    serviceIdSp = widget.serviceIdSp;
    _getServiceGroupData();
    _getSubServices(widget.serviceGroupId);
    _selectedValue = (widget.serviceGroupId).toString();
  }

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.shopping_cart, size: 30,color: Colors.white,),
            Icon(Icons.search, size: 30, color: Colors.white,),
            Icon(Icons.list_alt_rounded, size: 30, color: Colors.white,),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          color: Colors.black,
          buttonBackgroundColor: const Color(0xFFFED130),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;

              print("**********");
              print(index);

            });
          },
          letIndexChange: (index) => true,
        ), */
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
                  'Service auswählen',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400),
                ))),

        const Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 10),
          child: Text(
            'Ausgewählte Servicegruppe',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        //
        Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
            child: DropdownButtonFormField(
              value: _selectedValue,
              items: dropDownItemsSp,
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue as String;
                  _getSubServices(int.parse(newValue));
                });
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      const BorderSide(color: Color(0xFF0F0F0F), width: 1.0),
                ),
              ),
            )),

        Expanded(
          child: ListView.builder(
            itemCount: subServiceGroupDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        //height: 150,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subServiceGroupDataList[index]['name']
                                    .toString(),
                                style: const TextStyle(
                                    color: Color(0xFF0F0F0F),
                                    fontSize: 18,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500),
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
                                        text: '4.83 (25 Bewertungen)',
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
                              Text(
                                'Beginnt ab  €${subServiceGroupDataList[index]['price']} aufwärts',
                                style: const TextStyle(
                                    color: Color(0xFF0F0F0F),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500),
                              ),
                              ReadMoreText(
                                subServiceGroupDataList[index]['description']
                                    .toString(),
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Mehr anzeigen',
                                trimExpandedText: 'Weniger anzeigen',
                                moreStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Stack(
                            children: [
                              Card(
                                  color: Colors.white,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                          height: 90,
                                          fit: BoxFit.cover,
                                          imageUrl: '$baseurl/subservices/' +
                                              subServiceGroupDataList[index]
                                                  ['image_name'],
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)))),
                              Positioned(
                                  left: 25,
                                  top: 80,
                                  child: GestureDetector(
                                    onTap: () => {
                                      showModalBottomSheet<dynamic>(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15, bottom: 15),
                                                    child: Text(
                                                        "Sie haben den folgenden Service gewählt",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        //height: 150,
                                                        width: 300,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15,
                                                                  top: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                subServiceGroupDataList[
                                                                            index]
                                                                        ['name']
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFF0F0F0F),
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    Text.rich(
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            '\u2605',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.orange,
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'DM Sans',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            '4.83 (25 Bewertungen )',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF545454),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'DM Sans',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'Beginnt ab  €${subServiceGroupDataList[index]['price']} onwards ${subServiceGroupDataList[index]['id']}',
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFF0F0F0F),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                subServiceGroupDataList[
                                                                            index]
                                                                        [
                                                                        'description']
                                                                    .toString(),
                                                                maxLines: 2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        height: 110,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 15),
                                                          child: Card(
                                                              color:
                                                                  Colors.white,
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          8.0),
                                                                  child: CachedNetworkImage(
                                                                      height:
                                                                          90,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      imageUrl: '$baseurl/subservices/' +
                                                                          subServiceGroupDataList[index]
                                                                              [
                                                                              'image_name'],
                                                                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                                                                          value: downloadProgress
                                                                              .progress),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          const Icon(Icons.error)))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5,
                                                        left: 10,
                                                        right: 10),
                                                    child: Divider(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 25),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        _addToCart(
                                                            subServiceGroupDataList[
                                                                index]['id'],
                                                            subServiceGroupDataList[
                                                                index]['name']);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFFFED130),
                                                              minimumSize: const Size
                                                                  .fromHeight(
                                                                  60), // Set height to 10dp
                                                              fixedSize: const Size
                                                                  .fromWidth(
                                                                  double
                                                                      .infinity), // Set full width
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // Square border
                                                                side: const BorderSide(
                                                                    color: Color(
                                                                        0xFFFED130)), // Optional: black border
                                                              )),
                                                      child: const Text(
                                                        'Alle Anbieteroptionen anzeigen',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          })
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
                                            ' hinzufügen',
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
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Divider(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }

  _getServiceGroupData() async {
    print("_____+++++++++________");
    print(serviceIdSp);

    final response = await http
        .get(Uri.parse('$baseurl/home/services/get-details/$serviceIdSp'));

    //  print("_____+++++++++___serviceGroup___");
    // print(response.body);

    var servicePackageDataJson = jsonDecode(response.body);

    setState(() {
      dropDownItemsSp.clear();
    });

    for (final data in servicePackageDataJson['serviceGroupdata']) {
      dropDownItemsSp.add(DropdownMenuItem(
        value: data['id'].toString(),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('$baseurl/service-groups/' +
                  data['image_path']), // Replace with your image URL
            ),
            const SizedBox(width: 10),
            Text(data['name'].toString()),
          ],
        ),
      ));
    }
  }

  _getSubServices(int serviceGroupId) async {
    final response = await http
        .get(Uri.parse('$baseurl/home/services/details/$serviceGroupId'));

    // print("_____+++++++++___maybe subservice___");
    // print(response.body);
    // await storage.write(key: "subServiceId", value: response.body);

    var serviceDetailsDataJson = jsonDecode(response.body);


    setState(() {
      subServiceGroupDataList.clear();
    });

    for (final data in serviceDetailsDataJson['serviceData']) {
      subServiceGroupDataList.add(data);
    }
  }

  _addToCart(int subServiceId, String subServiceName) async {
    String? userToken = await storage.read(key: 'userToken');
    String? loggedEmail = await storage.read(key: 'loggedEmail');

    if (userToken == '' ||
        loggedEmail == '' ||
        userToken == null ||
        loggedEmail == null) {
      if (context.mounted) {
        const snackBar = SnackBar(
          content: Text('Session Expired! Please Login'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }


    final map = <String, dynamic>{};
    map['quant[]'] = '1';
    map['selected[]'] = subServiceId.toString();
    map['user_token'] = userToken;
    map['loggedin-email'] = loggedEmail;
    map['userSessionId'] = '';

    final response =
        await http.post(Uri.parse('$baseurl/home/services/cart'), body: map);

    var responseData = jsonDecode(response.body);

    // print(response.body);
    // print(responseData['userSession']);

    await storage.write(key: 'userSession', value: responseData['userSession']);
    await storage.write(key: 'subServiceName', value: subServiceName);
    await storage.write(key: 'subServiceId', value: subServiceId.toString());

    if (context.mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const Vendors()));
    }
  }
}
