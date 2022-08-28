import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '';
import '../data.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var publicKey = 'pk_test_5f8900fcaccc4be65ec4504ff93c9605ce22f922';
  final plugin = PaystackPlugin();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //used to generate a unique reference for payment
  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  //async method to charge users card and return a response
  chargeCard() async {
    var charge = Charge()
      ..amount = int.parse(widget.product.price)*
          100 //the money should be in kobo hence the need to multiply the value by 100
      ..reference = _getReference()
      ..putCustomField('custom_id',
          '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email = currentUser!.email.toString();

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    //check if the response is true or not
    if (response.status == true) {
      //you can send some data from the response to an API or use webhook to record the payment on a database
      _showMessage('Payment was successful!!!');
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      _showMessage('Payment Failed!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        // leading: IconButton(
        //   icon: const Icon(Icons.view_headline),
        //   onPressed: () {},
        // ),
        title: const Text('Galago'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Center(
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage(widget.product.image),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    '\$' + widget.product.price,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                  PayButton(
                    //call the chargeCard method
                    callback: () => chargeCard(),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({required this.callback});

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width*0.6,
        height: 45,
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          child: ElevatedButton(

            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              primary: Colors.blueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
            ),
            onPressed: callback,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Make Payment',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
