import 'package:flutter/material.dart';
import 'api/store.dart';
import 'api/lineItem.dart';
import 'success.dart';
import 'constant/currency_format.dart';

class CartMenu extends StatelessWidget {
  CartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ListTile> tiles = Store.getCart().map((LineItem item) {
      return ListTile(
          title: Text(
              '${item.item.itemName} - ${Format.toMoney(item.item.price)} x ${item.quantity}'),
          trailing: Text(Format.toMoney(item.getSubtotal())));
    }).toList();

    tiles.add(ListTile(
        title:
            const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(Format.toMoney(Store.getSalePrice()),
            style: const TextStyle(fontWeight: FontWeight.bold))));

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return Scaffold(
        appBar: AppBar(title: const Text('Cart 🛒')),
        body: Column(children: [
          ListView(shrinkWrap: true, children: divided),
          EnterCredentials()
        ]));
  }
}

class EnterCredentials extends StatefulWidget {
  EnterCredentials({super.key});

  @override
  EnterCredentialsState createState() => EnterCredentialsState();
}

class EnterCredentialsState extends State<EnterCredentials> {
  bool purchaseDisabled = true;
  bool failedAttempt = false;
  bool textDisabled = Store.cartEmpty();
  String textValue = "";
  bool transactionFailed = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Please enter your credentials',
          style: TextStyle(color: failedAttempt ? Colors.red : Colors.black)),
      Visibility(
        visible: transactionFailed,
        child: Text('Transaction Failed.',
            style: TextStyle(color: Colors.red[900], fontSize: 12)),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          readOnly: textDisabled,
          keyboardType: TextInputType.number,
          onChanged: (text) {
            textValue = text;
            purchaseDisabled = text.isEmpty ? true : false;
            setState(() => failedAttempt = false);
          },
        ),
      ),
      TextButton(
          child: const Text('Purchase'),
          onPressed: () {
            if (purchaseDisabled) {
              setState(() => failedAttempt = true);
              return;
            }

            if (Store.processPayment(textValue)) {
              _paymentSuccessful();
            } else {
              setState(() => transactionFailed = true);
            }
          })
    ]);
  }

  void _paymentSuccessful() {
    Navigator.of(context).push(MaterialPageRoute(
        maintainState: false,
        builder: (BuildContext context) => const PaymentSuccessful()));
  }
}
