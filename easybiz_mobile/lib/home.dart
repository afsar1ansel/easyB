import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easybiz_mobile/cart_summary.dart';
import 'package:easybiz_mobile/choose_pincode.dart';
import 'package:easybiz_mobile/notifications.dart';
import 'package:easybiz_mobile/services.dart';
import 'package:easybiz_mobile/settings.dart';
import 'package:easybiz_mobile/vendors.dart';
import 'package:elastic_autocomplete/elastic_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'my_orders.dart';
import 'urlconfig.dart';

//void main() => runApp(const MaterialApp(home: BottomNavBar()));

late TextEditingController serviceController;
List<String> options = [];
List serviceDataList = [];



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _page = 0;
  String showPincode = 'Ort wählen \u25BC';
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
 String name = 'User';
  
  Future<void> fetchUserData() async {
    // Retrieve the username from FlutterSecureStorage
    final storedUsername = await storage.read(key: 'username');

    setState(() {
      name = storedUsername ??
          'User';
    });
  }

  Future<void> readPincodeData() async {
    await Future.delayed(const Duration(seconds: 1));
    String pincodeValue =
        (await storage.readAll())['pincode'] ?? 'Ort wählen \u25BC';

    print("++++++++Got Pincode+++++++++");
    print(pincodeValue);

    setState(() {
      showPincode = pincodeValue;
    });
    print("*************");
    print(showPincode);
  }

  @override
  void initState() {
    // TODO: implement initState
    readPincodeData();
    getServicesData();
    fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          const Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          GestureDetector(
            child:
                const Icon(Icons.shopping_cart, size: 30, color: Colors.white),
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Settings()))
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
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/location.png'),
                      width: 40,
                      height: 50,
                    ),
                    GestureDetector(
                        child: Text(
                          showPincode,
                          style: const TextStyle(
                            color: Color(0xFF060606),
                            fontSize: 15,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Pincode()))
                            })
                  ],
                ),
              )),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: ServicesSearchAutoComplete(),
          ),
           Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hallo $name 👋',
                  style: TextStyle(
                    color: Color(0xFF887E5B),
                    fontSize: 20,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: SizedBox(
              child: Text(
                'Wonach suchen Sie heute ?',
                style: TextStyle(
                  color: Color(0xFF060606),
                  fontSize: 26,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.96,
                ),
              ),
            ),
          ),
          Expanded(
              //
              child: GridView.builder(
                  //childAspectRatio: 0.5,
                  itemCount: serviceDataList.length,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (showPincode == 'Ort wählen \u25BC') {
                              const snackBar = SnackBar(
                                content: Text('Bitte wählen Sie den PIN-Code'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Services(
                                            serviceId: serviceDataList[index]
                                                ['id'],
                                          )));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 180,
                              width: 180,
                              padding: const EdgeInsets.all(12), // Border width
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFFF6D7),
                                  shape: BoxShape.circle),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        48), // Image radius
                                    child: CachedNetworkImage(
                                        imageUrl: '$baseurl/service-image/' +
                                            serviceDataList[index]
                                                ['image_path'],
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons
                                                .error)) //Image.network('$baseurl/service-image/'+serviceDataList[index]['image_path'],fit: BoxFit.cover)
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          serviceDataList[index]['name'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF0F0F0F),
                            fontSize: 15,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    );
                  })),
        ],
      ),
    );
  }

  Future<int> getServicesData() async {
    final response = await http.get(Uri.parse('$baseurl/home/services/all'));

    var serviceDataJson = jsonDecode(response.body);

    setState(() {
      serviceDataList.clear();
    });

    for (final data in serviceDataJson['jsondata']) {
      serviceDataList.add(data);
    }

    return serviceDataList.length;
  }
}


class ServicesSearchAutoComplete extends StatefulWidget {
  const ServicesSearchAutoComplete({super.key});

  @override
  ServicesSearchAutoCompleteState createState() =>
      ServicesSearchAutoCompleteState();
}

class ServicesSearchAutoCompleteState
    extends State<ServicesSearchAutoComplete> {
  @override
  void initState() {
    serviceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElasticAutocomplete<String>(
      key: GlobalKey(),
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }

        options = [];

        final map = <String, dynamic>{};
        map['query'] = textEditingValue.text;

        final response = await http
            .post(Uri.parse('$baseurl/home/services/search'), body: map);

        final body = json.decode(response.body);
        String serviceData = '';
        for (var s in body) {
          serviceData = s['name'];
          options.add(serviceData);
        }

        return options.toSet().toList();
      },
      onSelected: (String value) => {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Vendors()))
      },
      fieldViewBuilder: (BuildContext context, serviceController,
          FocusNode focusNode, void Function() onFieldSubmitted) {
        return TextFormField(
            autofocus: false,
            // You must set controller, focusNode, and onFieldSubmitted
            // in the textFormField
            controller: serviceController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Suchen Sie nach einem Service, z. B. Autowäsche',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ));
      },
    );
  }
}
