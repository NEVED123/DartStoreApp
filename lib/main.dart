import 'package:flutter/material.dart';
import 'store.dart';
import 'saleitem.dart';
import 'lineItem.dart';

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
      home: const Scaffold(body: ItemsForSale()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ItemsForSale extends StatefulWidget {
  const ItemsForSale({super.key});
  @override
  ItemsForSaleState createState() => ItemsForSaleState();
}

class ItemsForSaleState extends State<ItemsForSale> {
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
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final List<ListTile> tiles = Store.getCart().map((LineItem item) {
        return ListTile(
            title: Text(
                '${item.item.itemName} - \$${item.item.price} x ${item.quantity}'),
            trailing: Text('...\$${item.getSubtotal()}'));
      }).toList();

      tiles.add(ListTile(
          title: const Text('Total:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('\$${Store.getSalePrice()}',
              style: TextStyle(fontWeight: FontWeight.bold))));

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: const Text('Cart 🛒')),
          body: Column(children: <Widget>[
            ListView(shrinkWrap: true, children: divided),
          ]));
    }));
  }
}
