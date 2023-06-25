import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.indigoAccent,
          secondaryHeaderColor: Colors.green),
      home: Scaffold(body: ItemsForSale()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ItemsForSale extends StatefulWidget {
  @override
  ItemsForSaleState createState() => ItemsForSaleState();
}

class ItemsForSaleState extends State<ItemsForSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('🎯 Dart Store 🎯'), actions: const <Widget>[
        Badge(
          label: Text('#'),
          child: Icon(Icons.shopping_cart),
        )
      ]),
    );
  }

  void _viewCartPressed() {}
}
