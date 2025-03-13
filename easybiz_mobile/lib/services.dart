import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'urlconfig.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easybiz_mobile/service_packages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


int serviceId = 0;
List serviceGroupDataList = [];

class Services extends StatefulWidget {
  final int serviceId;
  const Services({super.key, required this.serviceId});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends State<Services> {

  String _selectedValue = '1';
  int keyCount = 0;

  @override
  void initState() {
      serviceId = widget.serviceId;
      _getServiceGroupData();
      _getAllCategoryData();
      _selectedValue = serviceId.toString();
  }

  List<DropdownMenuItem<String>> dropDownItems = [];


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
                      padding: EdgeInsets.only(
                          top: 60,
                          left: 12
                      ),
                      child: Text(
                        'Choose a Service',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400
                        ),
                      )
                  )
                  ),
                const Padding(padding: EdgeInsets.only(top:15,left: 15,right: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selected Category',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0F0F0F),
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 2
                    ),
                    child: DropdownButtonFormField(
                      value: _selectedValue,
                      items: dropDownItems,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue as String;
                          serviceId = int.parse(newValue);
                          keyCount++;
                          _getServiceGroupData();
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                    )
                  ),

                Expanded(
                    child: GridView.builder(
                      key: ValueKey(keyCount),
                    primary: false,
                    itemCount: serviceGroupDataList.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8
                    ),
                    itemBuilder: (BuildContext context, int index) {

                    return GestureDetector(
                      onTap: () => {

                        Navigator.push(context,
                           MaterialPageRoute(builder: (_) => ServicesPackages(serviceIdSp: serviceId,serviceGroupId:serviceGroupDataList[index]['id']))
                        )

                      },
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.only(top:10,left: 10,right: 10),
                            child : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    height: 200, //can be removed or changed
                                    imageUrl: '$baseurl/service-groups/'+serviceGroupDataList[index]['image_path'],
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => const Icon(Icons.error)
                                  )
                                ),

                                Padding(padding: const EdgeInsets.only(top: 5),child: Text(
                                  serviceGroupDataList[index]['name'].toString(),
                                  style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                ),
                              ],
                            )
                        ),
                      ),
                    );


                  },)
                ),
              ],
          )
      );
  }

  _getServiceGroupData() async {

    print("_____+++++++++________");
    print(serviceId);

    final response = await http.get(
        Uri.parse('$baseurl/home/services/get-details/$serviceId')
    );

    var servicePackageDataJson = jsonDecode(response.body);

    setState(() {
      serviceGroupDataList.clear();
    });

    for(final data in servicePackageDataJson['serviceGroupdata'])
    {
      serviceGroupDataList.add(data);
    }

    return serviceGroupDataList.length;
  }

  _getAllCategoryData() async {

      final response = await http.get(
          Uri.parse('$baseurl/home/services/all')
      );

      var serviceDataJson = jsonDecode(response.body);

      setState(() {
        dropDownItems.clear();
      });

      for(final data in serviceDataJson['jsondata'])
      {
            dropDownItems.add(
                DropdownMenuItem(
                  value: data['id'].toString(),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('$baseurl/service-image/'+data['image_path']), // Replace with your image URL
                      ),
                      const SizedBox(width: 10),
                      Text(data['name'].toString()),
                    ],
                  ),
                )
            );
      }

  }

}