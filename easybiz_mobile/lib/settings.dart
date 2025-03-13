import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'cart_summary.dart';
import 'home.dart';
import 'my_orders.dart';
import 'notifications.dart';

class Settings extends StatefulWidget {

  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int _page = 3;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 3,
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
              _page = index;

              print("**********");
              print(index);

            });
          },
          letIndexChange: (index) => true,
        ),
        body: Column(
            children: [
              const Row(
                mainAxisAlignment : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 50
                      ),
                      child: Text(
                        'Passwort ändern',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Altes Passwort',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true, // Enables background color filling
                    fillColor: Colors.white, // Set the background color to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Neues Passwort',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true, // Enables background color filling
                    fillColor: Colors.white, // Set the background color to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Passwort wiederholen',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true, // Enables background color filling
                    fillColor: Colors.white, // Set the background color to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
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
                    child: const Text(' Passwort ändern ',style: TextStyle(color: Colors.white, fontSize: 20),)
                ),
              )
            ],
        ),
    );
  }

}