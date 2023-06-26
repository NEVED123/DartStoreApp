import 'saleitem.dart';
import 'sale.dart';
import 'lineItem.dart';

class Store {
  static final List<SaleItem> _saleItems = <SaleItem>[];
  static Sale? _sale;

  static void _addSaleItem(int id, String itemName, double price, String desc) {
    _saleItems.add(SaleItem(id, itemName, price, desc));
  }

  static void initializeSale() {
    _sale = Sale();
    //In real life, this would be a database request
    _addSaleItem(0, '🍌 Banana', 1.00, "The best you'll ever have!");
    _addSaleItem(1, '🍊 Orange', 1.25, "The worst you'll ever have!");
    _addSaleItem(2, '🍎 Apple', 1.50, "It's okay I guess");
    _addSaleItem(3, '🍔 Steamed Ham', 100,
        "Well, Seymour, you are an odd fellow, but I must say... you steam a good ham.");
    _addSaleItem(4, '🥝 Kiwi', 25.00, "Gnaw at it");
    _addSaleItem(5, '🎯 Dart Board', 100.00, "Delicious and nutritious");
    _addSaleItem(6, '☠️ Some skull I found', 200.00, "Great source of calcium");
    _addSaleItem(7, '🎈 Balloon', .10, "Make your dreams come true");
    _addSaleItem(8, '♟️ Chess Piece', 10.00, "Board sold separately");
    _addSaleItem(9, '👶 Baby', 500.00, "We're also an orphanage");
    _addSaleItem(10, '🫵 Your clone', 1000.00,
        "Having a clone of yourself is convenient");
    _addSaleItem(11, '🥰 Love', 10.00,
        "They said you couldn't buy love, but here we are");
    _addSaleItem(12, '♨️ Java JDK 1.8', 30.00,
        "I give it an 11/10 - Most CS professors");
    _addSaleItem(13, '🌫️ Fog', 30.00, "Fun for the whole family!");
    _addSaleItem(
        14, '🈳 Whatever this is', 4.00, "It looks kinda cool I guess");
    _addSaleItem(15, '☢️ Nuclear waste', 1000.00,
        "It gives you super powers, who would'nt want that!");
  }

  static List<SaleItem> getSaleItems() {
    return _saleItems;
  }

  static List<LineItem> getCart() {
    if (_sale != null) {
      return _sale!.getCart();
    }

    return <LineItem>[];
  }

  static bool addToCart(int id, int quantity) {
    SaleItem item = getSaleItem(id);

    if (item != SaleItem.emptySaleItem) {
      return _sale!.addToCart(item, quantity);
    } else {
      return false;
    }
  }

  static bool decrementCartItem(int id, int quantity) {
    SaleItem item = getSaleItem(id);

    if (item != SaleItem.emptySaleItem) {
      return _sale!.decrementCartItem(item, quantity);
    } else {
      return false;
    }
  }

  static bool removeFromCart(int id) {
    SaleItem item = getSaleItem(id);

    if (item != SaleItem.emptySaleItem) {
      return _sale!.removeFromCart(item);
    } else {
      return false;
    }
  }

  static bool processPayment(String? creditNum) {
    if (creditNum == null || creditNum == "BAD") {
      return false;
    }

    return true;
  }

  static double getSalePrice() {
    if (_sale == null) {
      return 0;
    }

    return _sale!.getPrice();
  }

  static int getCartQuantity(int id) {
    if (_sale == null) return 0;

    LineItem selectedItem = _sale!.getCart().firstWhere(
        (curr) => curr.item.id == id,
        orElse: () => LineItem.emptyLineItem);

    if (selectedItem == LineItem.emptyLineItem) {
      return 0;
    }

    return selectedItem.quantity;
  }

  static SaleItem getSaleItem(int id) {
    if (_sale == null) {
      return SaleItem.emptySaleItem;
    }

    SaleItem selectedItem = _saleItems.firstWhere((curr) => curr.id == id,
        orElse: () => SaleItem.emptySaleItem);

    if (selectedItem == SaleItem.emptySaleItem) {
      return SaleItem.emptySaleItem;
    }

    return selectedItem;
  }
}
