import 'dart:convert';
import 'package:elastic_autocomplete/elastic_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'urlconfig.dart';

// Global variables
String selectablePincodeData = '';
List<String> options = [];
late TextEditingController pincodeController;

const FlutterSecureStorage storage = FlutterSecureStorage();

class Pincode extends StatefulWidget {
  const Pincode({super.key});

  @override
  PincodeState createState() => PincodeState();
}

class PincodeState extends State<Pincode> {
  int selectedDistance = 10; // Default selected distance
  List<int> distances = [5, 10, 15, 20, 30, 50]; // Distance options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 15),
            child: Icon(Icons.arrow_back),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Postleitzahl nutzen, um Verfügbarkeit zu prüfen.',
                  style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Pincode Autocomplete Feature
                PincodeAutoComplete(
                    selectedDistance:
                        selectedDistance), // Pass selectedDistance

                const SizedBox(height: 15),

                // Dropdown for Distance Selection
                DropdownButtonFormField<int>(
                  value: selectedDistance,
                  items: distances.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text("$value km"),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedDistance = newValue;
                      });
                      print("Selected Distance: $selectedDistance km");
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Umkreis auswählen",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Home()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFED130),
                    minimumSize: const Size.fromHeight(55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Diese Postleitzahl wählen',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Fetch all pincodes from API
Future<void> getAllPincode() async {
  options = [];
  final response =
      await http.get(Uri.parse('$baseurl/home/search/pincode/all'));
  final body = json.decode(response.body);

  for (var s in body) {
    String pincodeData = s['pincode'] + ' - ' + s['city_name'];
    options.add(pincodeData);
  }
}

// Pincode Autocomplete Feature
class PincodeAutoComplete extends StatefulWidget {
  final int selectedDistance; // Add this parameter
  const PincodeAutoComplete(
      {super.key, required this.selectedDistance}); // Update constructor

  @override
  PincodeAutoCompleteState createState() => PincodeAutoCompleteState();
}

class PincodeAutoCompleteState extends State<PincodeAutoComplete> {
  @override
  void initState() {
    super.initState();
    pincodeController = TextEditingController();
    getAllPincode();
  }

  @override
  void dispose() {
    pincodeController.dispose();
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
      onSelected: (String selection) async {
        print("Selected Pincode: $selection");

        // Store the selected pincode immediately
        await storage.write(key: 'pincode', value: selection);

        // Read and print stored value
        String data = (await storage.read(key: 'pincode')) ?? '';
        print("Stored Pincode: $data");
      },
      fieldViewBuilder: (BuildContext context, pincodeController,
          FocusNode focusNode, void Function() onFieldSubmitted) {
        return TextFormField(
          controller: pincodeController,
          focusNode: focusNode,
          onTapOutside: (value) async {
            print("-----Chosen Pincode----------");
            print(pincodeController.text);

            await storage.write(key: 'pincode', value: pincodeController.text);
            String data = (await storage.readAll())['pincode'] ?? '';
            print(data);

            RegExp regExp = RegExp(r'\d+');
            Match? match = regExp.firstMatch(data);
            String numericPart = match != null ? match.group(0)! : '';

            print(numericPart); // filtered pincode for fetch

            // Print the selected distance
            print("Selected Distance: ${widget.selectedDistance} km");

           // Example API call (commented out)
            try {
              final response = await http.get(Uri.parse('https://easybizz.de/easybizz_api/vendor/nearbypincode/$numericPart/${widget.selectedDistance * 1000}'));

              if (response.statusCode == 200) {
                print(response.body);
              }
            } catch (e) {
              print(e);
            }
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
          ),
        );
      },
    );
  }
}
