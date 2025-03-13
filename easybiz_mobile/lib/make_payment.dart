import 'package:flutter/material.dart';
import 'cart_summary.dart';

void main() async {
  //Initialize Flutter Binding
  //WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  //Stripe.publishableKey = "pk_test_51MJnsyDNh0Sp9L0KqvSu8pOcI3SD8EefIEL7tciz7pBJjMxxaC3ueOZq1cTJuRkjmAZfalyvdoLZMPpxp3dT5sRm00ivv9zfxa";

  //Stripe.merchantIdentifier = 'QNR87687687686876';
  //await Stripe.instance.applySettings();

  //Load our .env file that contains our Stripe Secret key
  //await dotenv.load(fileName: "assets/.env");

  runApp(const MakePaymentTrigger());
}

class MakePaymentTrigger extends StatelessWidget {
  const MakePaymentTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //initial route
      home: const CartSummary(),
    );
  }
}