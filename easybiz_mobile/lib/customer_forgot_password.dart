import 'dart:convert';
import 'package:easybiz_mobile/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'urlconfig.dart';

class CustomerForgotPassword extends StatefulWidget {
  const CustomerForgotPassword({super.key});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<CustomerForgotPassword> {
  final emailController = TextEditingController();
  String buttonName = 'Passwort zurücksetzen';
  late bool _isDisable = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
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
                  padding: const EdgeInsets.only(top: 80),
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
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Passwort vergessen',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 36,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
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
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _isDisable ? null : validateForm();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(65), // Set height to 10dp
                  fixedSize:
                      const Size.fromWidth(double.infinity), // Set full width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Square border
                    side: const BorderSide(
                        color: Colors.black), // Optional: black border
                  )),
              child: Text(
                buttonName,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Text(
                  'Passwort bekannt ?  ',
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

  Future<String> customerForgotPassword(String email) async {
    final map = <String, dynamic>{};
    map['email'] = email;

    final response = await http.post(
      Uri.parse('$baseurl/customer/forgot-password/'),
      body: map,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var resData = ForgotPasswordResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      if (resData.errflag == 0) {
        return '1';
      }

      if (resData.errflag == 1) {
        return resData.message;
      }

      return '2';
    } else {
      return '0';
    }
  }

  Future<void> validateForm() async {
    var email = emailController.text;

    if (email == '') {
      const snackBar = SnackBar(
        content: Text('Bitte geben E-Mail-Adresse ein'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final resData = await customerForgotPassword(email);

    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      if (resData == '1') {
        const snackBar = SnackBar(
          content: Text('E-Mail zum Zurücksetzen des Passworts gesendet'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          buttonName =
              'E-Mail zum Zurücksetzen gesendet! Klicken Sie auf Anmelden';
          _isDisable = true;
        });
      } else if (resData == '2' || resData == '0') {
        const snackBar = SnackBar(
          content: Text('etwas ist schiefgelaufen'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (resData != '1' && resData != '0' && resData != '2') {
        const snackBar = SnackBar(
          content: Text('E-Mail nicht gefunden! Bitte melden Sie sich an'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}

class ForgotPasswordResponse {
  final int errflag;
  final String message;

  ForgotPasswordResponse({required this.errflag, required this.message});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'errflag': int errflag,
        'message': String message,
      } =>
        ForgotPasswordResponse(
          errflag: errflag,
          message: message,
        ),
      _ => throw const FormatException('Link konnte nicht gesendet werden.'),
    };
  }
}
