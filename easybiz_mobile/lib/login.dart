import 'dart:convert';
import 'package:easybiz_mobile/customer_forgot_password.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';
import 'signup.dart';
import 'urlconfig.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final storage = const FlutterSecureStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _isLoading = false;
  var _isLoadingGoogle = false;

  ValueNotifier userCredential = ValueNotifier('');

  Future<dynamic> signInWithGoogle() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
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
                    'anmelden',
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
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 20, right: 20),
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
              obscureText: true,
              controller: passwordController,
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
                validateForm();
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
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : const Text(
                      'Anmelden',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                child: const Text(
                  'Passwort vergessen?',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CustomerForgotPassword()))
                },
              )),
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
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(65), // Set height to 10dp
                fixedSize:
                    const Size.fromWidth(double.infinity), // Set full width
              ),
              onPressed: () async {
                setState(() {
                  _isLoadingGoogle = true;
                });

                userCredential.value = await signInWithGoogle();
                if (userCredential.value != null) {
                  print("++++++++++++");
                  print(userCredential.value);
                  print(userCredential.value.credential!.accessToken);
                  print(userCredential.value.user!.displayName);
                  print(userCredential.value.user!.email);
                  print("++++++++++++");

                  _loginWithGoogle(
                      userCredential.value.credential!.accessToken,
                      userCredential.value.user!.displayName,
                      userCredential.value.user!.email);
                } else {
                  if (context.mounted) {
                    const snackBar = SnackBar(
                      content: Text('Anmeldung mit Google nicht möglich'),
                      showCloseIcon: true,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: _isLoadingGoogle
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 3,
                    )
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage("assets/images/google_signin.png"),
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
                  'Neu bei Easybizz ?  ',
                  style: TextStyle(
                    color: Color(0xFF3A3A3A),
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Signup())),
                    child: const Text(
                      'Jetzt registrieren',
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

  Future<int> loginCustomer(String email, String password) async {
    await storage.deleteAll();

    final map = <String, dynamic>{};
    map['pswd'] = password;
    map['uname'] = email;
    int navigateFlag;

    final response = await http.post(
      Uri.parse('$baseurl/customer/login'),
      body: map,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var resData = SigninResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      print(resData.userToken);

      if (resData.userToken != 'notoken') {
        await storage.write(key: 'userToken', value: resData.userToken);

        await storage.write(key: 'username', value: resData.username);

        await storage.write(key: 'loggedEmail', value: email);

        navigateFlag = 1;
        return navigateFlag;
      }

      if (resData.errflag == 1) {
        navigateFlag = 2;
        return navigateFlag;
      }

      return 0;
    } else {
      return 0;
    }
  }

  Future<void> validateForm() async {
    var email = emailController.text;
    var password = passwordController.text;

    if (email == '') {
      const snackBar = SnackBar(
        content: Text('Bitte geben Sie E-Mail-Adresse ein'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (password == '') {
      const snackBar = SnackBar(
        content: Text('Bitte geben Sie das Passwort ein'),
        showCloseIcon: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final resData = await loginCustomer(email, password);

    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      if (resData == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Home()));
      } else if (resData == 2) {
        const snackBar = SnackBar(
          content: Text('Email /  Passwort ist falsch'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoading = false;
        });
      } else if (resData == 0) {
        const snackBar = SnackBar(
          content: Text('Leider ist etwas schief gelaufen.'),
          showCloseIcon: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _loginWithGoogle(String accessToken, String username, String email) async {
    final map = <String, dynamic>{};
    map['authToken'] = accessToken;
    map['username'] = username;
    map['email'] = email;

    final response = await http.post(
      Uri.parse('$baseurl/mobile/customer/google-signin'),
      body: map,
    );

    print("+++++++++++++++");
    print(response.body);

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      await storage.write(key: 'userToken', value: body['userToken']);

      await storage.write(key: 'username', value: body['username']);

      await storage.write(key: 'loggedEmail', value: email);

      if (context.mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Home()));
      }

      if (body['errFlag'] == 1) {
        if (context.mounted) {
          const snackBar = SnackBar(
            content: Text('Anmeldung mit Google nicht möglich.'),
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          setState(() {
            _isLoadingGoogle = false;
          });
        }
      }
    }
  }
}

class SigninResponse {
  final int errflag;
  final String message;
  final String userToken;
  final String username;
  final String loginTime;
  final String loginDate;

  SigninResponse(
      {this.errflag = 0,
      this.message = 'empty',
      this.userToken = 'notoken',
      this.loginDate = 'empty',
      this.loginTime = 'empty',
      this.username = 'empty'});

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userToken': String userToken,
        'username': String username,
        'loginTime': String loginTime,
        'loginDate': String loginDate
      } =>
        SigninResponse(
            userToken: userToken,
            username: username,
            loginTime: loginTime,
            loginDate: loginDate),
      {
        'errflag': int errflag,
        'message': String message,
      } =>
        SigninResponse(
          errflag: errflag,
          message: message,
        ),
      _ => throw const FormatException('Anmeldung fehlgeschlagen.'),
    };
  }
}
