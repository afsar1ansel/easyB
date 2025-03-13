import 'dart:convert';
import 'package:elastic_autocomplete/elastic_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'urlconfig.dart';


String selectablePicodeData = '';
List<String> options = [];
late TextEditingController pincocdeController;

const FlutterSecureStorage storage = FlutterSecureStorage();

class Pincode extends StatefulWidget {
  const Pincode({super.key});

  @override
  PincodeState createState() => PincodeState();
}

class PincodeState extends State<Pincode> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [

                const Padding(padding: EdgeInsets.only(top: 50,left: 15),
                    child: Icon(Icons.arrow_back),
                ),

                Padding(padding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15
                ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Postleitzahl nutzen, um Verfügbarkeit zu prüfen.',
                          style: TextStyle(
                              color: Color(0xFF0F0F0F),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        const PincodeAutoComplete(),

                        const SizedBox(
                            height: 10,
                        ),

                        ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const Home())
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFED130),
                                minimumSize: const Size.fromHeight(55), // Set height to 10dp
                                fixedSize: const Size.fromWidth(double.infinity), // Set full width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Square border
                                  //side: const BorderSide(color: Colors.black), // Optional: black border
                                )
                            ),
                            child: const Text('Diese Postleitzahl wählen',style: TextStyle(color: Colors.black, fontSize: 20),),
                          ),


                      ],
                    ),
                  ),
                )

            ],
        )
    );
  }

}



Future<void> getAllPincode() async {

  options = [];

  final response = await http.get(
      Uri.parse('$baseurl/home/search/pincode/all')
  );

  final body = json.decode(response.body);
  String pincodeData = '';
  for (var s in body) {
      pincodeData = s['pincode']+' - '+s['city_name'];
      options.add(pincodeData);
  }
}


class PincodeAutoComplete extends StatefulWidget{

  const PincodeAutoComplete({super.key});

  @override
  PincodeAutoCompleteState createState() => PincodeAutoCompleteState();

}

class PincodeAutoCompleteState extends State<PincodeAutoComplete> {

  @override
  void initState() {
    // TODO: implement initState

    pincocdeController = TextEditingController();
    getAllPincode();
    super.initState();
  }

  @override
  void dispose() {
    pincocdeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElasticAutocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) async {

          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }

          return options.where((String option) {
            return option.contains(textEditingValue.text);
          });

          },
        fieldViewBuilder: (BuildContext context, pincocdeController,
        FocusNode focusNode,
        void Function() onFieldSubmitted) {
      return TextFormField(
          autofocus: true,
          // You must set controller, focusNode, and onFieldSubmitted
          // in the textFormField
          controller: pincocdeController,
          focusNode: focusNode,
          /*onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },*/
          onTapOutside: (value) async {

              print("-----Choosen Pincode----------");
              print(pincocdeController.text);

              //await storage.delete(key: 'pincode');
              await storage.write(
                  key: 'pincode',
                  value: pincocdeController.text
              );
              String data = (await storage.readAll())['pincode'] ?? '';
              print(data);
          },
          decoration: InputDecoration(
              hintText: 'Postleitzahl eingeben',
              prefixIcon: const Icon(Icons.pin_drop_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
      ));
    });
  }

}