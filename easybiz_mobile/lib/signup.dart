import 'package:easybiz_mobile/home.dart';
import 'package:easybiz_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'urlconfig.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();

  var _isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFED130),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Image.asset(
                    "assets/images/easybiz_logo.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Registrieren',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 30,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: nameController,
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: emailController,
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Handynummer ohne Landesvorwahl',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: mobileController,
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
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Passwort',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: passwordController,
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
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () {
                  validateForm();
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Home())
                  );*/
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize:
                        const Size.fromHeight(65), // Set height to 10dp
                    fixedSize:
                        const Size.fromWidth(double.infinity), // Set full width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Square border
                      side: const BorderSide(
                          color: Colors.black), // Optional: black border
                    )),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                    : const Text(
                        'Registrieren',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ) //const Text('Signup',style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 150,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      'oder',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF3A3A3A),
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    width: 150,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize:
                    const Size.fromWidth(double.infinity), // Set full width
              ),
              onPressed: () {
                //googleLogin();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/google_signin.png"),
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 8),
                      child: Text(
                        'Mit Google anmelden',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Text(
                  'Bereits ein Benutzer ?  ',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Login())),
                    child: const Text(
                      'Anmelden',
                      style: TextStyle(
                          color: Color(0xFF3A3A3A),
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  final storage = const FlutterSecureStorage();

  Future<int> createCustomer(
      String name, String password, String mobile, String email) async {
    final map = <String, dynamic>{};
    map['username'] = name;
    map['password'] = password;
    map['phone'] = mobile;
    map['email'] = email;
    int navigateFlag;

    final response = await http.post(
      Uri.parse('$baseurl/customer/signup'),
      body: map,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var resData = SignupResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      if (resData.errflag == 0) {
        print(resData.userToken);

        await storage.write(key: 'userToken', value: resData.userToken);
        navigateFlag = 1;
      } else {
        navigateFlag = 2;
      }

      return navigateFlag;
    } else {
      return 0;
    }
  }

  Future<void> validateForm() async {
    var name = nameController.text;
    var email = emailController.text;
    var mobile = mobileController.text;
    var password = passwordController.text;

    if (name == '') {
      const snackBar = SnackBar(
        content: Text('Please Enter Name'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (email == '') {
      const snackBar = SnackBar(
        content: Text('Please Enter Email'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (mobile == '') {
      const snackBar = SnackBar(
        content: Text('Please Enter Mobile Without Country Code'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (password == '') {
      const snackBar = SnackBar(
        content: Text('Please Enter Password'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final resData = await createCustomer(name, password, mobile, email);

    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      if (resData == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Home()));
      } else if (resData == 2) {
        const snackBar = SnackBar(
          content: Text('Email Already Registed! Please Login'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoading = false;
        });
      } else if (resData == 0) {
        const snackBar = SnackBar(
          content: Text('Something Went Wrong'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class SignupResponse {
  final int errflag;
  final String message;
  final String userToken;

  SignupResponse(
      {required this.errflag,
      required this.message,
      this.userToken = 'notoken'});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'errflag': int errflag,
        'message': String message,
        'userToken': String userToken
      } =>
        SignupResponse(
            errflag: errflag, message: message, userToken: userToken),
      {
        'errflag': int errflag,
        'message': String message,
      } =>
        SignupResponse(
          errflag: errflag,
          message: message,
        ),
      _ => throw const FormatException('Failed to Signup.'),
    };
  }
}
