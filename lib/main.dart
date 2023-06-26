import 'package:flutter/material.dart';
import 'api/store.dart';
import 'home.dart';

void main() {
  Store.initializeSale();
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
      home: const Scaffold(body: Home()),
      debugShowCheckedModeBanner: false,
    );
  }
}
