import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          foregroundColor: Colors.black,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.email),
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Benachrichtigungen',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints:
                    const BoxConstraints(minHeight: 0, maxHeight: 120.0),
                child: const Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image(
                                  image: AssetImage('assets/images/tick.png'),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Sie haben eine Buchung\n für  ',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'die Autowäsche & \n Politur bestätigt!',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '!',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Datum: 29-02-2024 | Time: 15:30 hrs ',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Buchungs-ID : ABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints:
                    const BoxConstraints(minHeight: 0, maxHeight: 130.0),
                child: const Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/order_success.png'),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Zahlung erfolgreich',
                                        style: TextStyle(
                                          color: Color(0xFF1A922D),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' für\n',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Autowäsche und Politur!',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Zahlungs-ID: ABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  'Buchungs-ID : FABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  'Bezahlter Betrag: €159',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints:
                    const BoxConstraints(minHeight: 0, maxHeight: 130.0),
                child: const Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/order_failure.png'),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Zahlung fehlgeschlagen',
                                        style: TextStyle(
                                          color: Color(0xFFF44336),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' für\n',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Autowäsche und Politur!',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Zahlungs-ID : ABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  'Buchungs-ID: FABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  'Bezahlter Betrag: €159',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints:
                    const BoxConstraints(minHeight: 0, maxHeight: 130.0),
                child: const Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/vendor_accepted.png'),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Der Anbieter hat Ihre Bestellung \n',
                                        style: TextStyle(
                                          color: Color(0xFF1A922D),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Autowäsche und Politur akzeptiert!',
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Datum: 29-02-2024 | Time: 15:30 hrs ',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Buchungs-ID: FABCD420690007',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                constraints:
                    const BoxConstraints(minHeight: 0, maxHeight: 140.0),
                child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/service_complete.png'),
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ihr Service wurde abgeschlossen!',
                                  style: TextStyle(
                                    color: Color(0xFF0F0F0F),
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Ihr Serviceauftrag für den Damen-Salon & Spa,\n bestehend aus mehreren Leistungen, wurde \nabgeschlossen.',
                                  style: TextStyle(
                                    color: Color(0xFF5E5E5E),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 25,
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 21, right: 20, bottom: 3),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFFE3E3E3)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Feedback geben',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF1F1F1F),
                                          fontSize: 10,
                                          fontFamily: 'Segoe UI',
                                          fontWeight: FontWeight.w600,
                                          height: 0.20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ]));
  }
}
