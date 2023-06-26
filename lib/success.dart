import 'package:flutter/material.dart';
import 'api/store.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Purchase Successful 🎉'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const Text('Thank you for shopping at the Dart Store!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                )),
            TextButton(
                child: const Text('Make another purchase'),
                onPressed: () => _returnToHome(context))
          ])),
    );
  }

  void _returnToHome(BuildContext context) {
    Store.initializeSale();
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
