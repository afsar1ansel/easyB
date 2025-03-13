import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Easybiz App',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFED130), // Set background color to green
      body: Stack(children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/easybiz_logo.png",
                height: 220,
                width: 220,
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Ihre Heimdienstleistungen',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 15,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.07,
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Schnell \u2022 Günstig \u2022 Vertrauenswürdig',
                  style: TextStyle(
                    color: Color(0xFF545454),
                    fontSize: 13,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,
                    height: 0.12,
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const Walkthrough())))
      ]),
    );
  }
}

class Walkthrough extends StatelessWidget {
  const Walkthrough({super.key});

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>(); //new aded

    return IntroductionScreen(
      key: introKey,
        pages: [
          PageViewModel(
              title:
                  "Wir bieten professionelle Heimdienstleistungen zu einem sehr freundlichen Preis an",
              bodyWidget: GestureDetector(
                onTap: () => introKey.currentState?.next(),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFED130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              image: Container(
                height: 290,
                width: 290,
                padding: const EdgeInsets.all(12), // Border width
                decoration: const BoxDecoration(
                    color: Color(0xFFFFF6D7), shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.asset(
                        "assets/images/s1.png",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              decoration: const PageDecoration(
                  titleTextStyle: TextStyle(
                      color: Color(0xFF1A1D1F),
                      fontSize: 28,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700)
                  //titlePadding: EdgeInsets.only(top:100),
                  //imagePadding: EdgeInsets.only(top:100),
                  )),
          PageViewModel(
              title: "Einfache Servicebuchung und Terminplanung",
              bodyWidget: GestureDetector(
                onTap: () => introKey.currentState?.next(),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFED130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              image: Container(
                height: 290,
                width: 290,
                padding: const EdgeInsets.all(12), // Border width
                decoration: const BoxDecoration(
                    color: Color(0xFFFFF6D7), shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.asset(
                        "assets/images/s2.png",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              decoration: const PageDecoration(
                  titleTextStyle: TextStyle(
                      color: Color(0xFF1A1D1F),
                      fontSize: 28,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700)
                  //titlePadding: EdgeInsets.only(top:100),
                  //imagePadding: EdgeInsets.only(top:100),
                  )),
          PageViewModel(
              title:
                  "Ihr Schönheitssalon für zuhause und weitere persönliche Pflegeleistungen.",
              bodyWidget: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Login()))
                },
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFED130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              image: Container(
                height: 290,
                width: 290,
                padding: const EdgeInsets.all(12), // Border width
                decoration: const BoxDecoration(
                    color: Color(0xFFFFF6D7), shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.asset(
                        "assets/images/s3.png",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              decoration: const PageDecoration(
                  titleTextStyle: TextStyle(
                      color: Color(0xFF1A1D1F),
                      fontSize: 28,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700)
                  //titlePadding: EdgeInsets.only(top:100),
                  //imagePadding: EdgeInsets.only(top:100),
                  )),
        ],
        onDone: () {
          // Handle the action when the user taps done on the last page
          // Navigate to the main screen or the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
        },
        showNextButton: false,
        done: const Text("Login"),
        showSkipButton: false);
  }
}
