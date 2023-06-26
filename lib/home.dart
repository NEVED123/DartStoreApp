import 'package:flutter/material.dart';
import 'api/store.dart';
import 'api/saleitem.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('🎯 Dart Store 🎯'), actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _viewCartPressed,
              ))
        ]),
        body: ListView(
          children: _getShoppingTiles(),
        ));
  }

  List<Widget> _getShoppingTiles() {
    List<Widget> tiles = <Widget>[];

    for (SaleItem saleItem in Store.getSaleItems()) {
      tiles.add(_getShoppingTile(saleItem));
    }

    return tiles;
  }

  Widget _getShoppingTile(SaleItem saleItem) {
    return ListTile(
        title: Text('${saleItem.itemName} - \$${saleItem.price}'),
        subtitle: Text(saleItem.desc),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                Store.decrementCartItem(saleItem.id, 1);
              });
            },
            child: const Text('-'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(Store.getCartQuantity(saleItem.id).toString()),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Store.addToCart(saleItem.id, 1);
              });
            },
            child: const Text('+'),
          ),
        ]));
  }

  void _viewCartPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => CartMenu()));
  }
}
