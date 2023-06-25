import 'saleitem.dart';
import 'sale.dart';
import 'lineItem.dart';

class Store {
  List<SaleItem> _saleItems = <SaleItem>[];
  Sale? _sale = null;

  Store() {
    //In real life, this would be a database request
    _addSaleItem(0, '🍌 Banana', 1.00, "The best you'll ever have!");
    _addSaleItem(1, '🍊 Orange', 1.25, "The worst you'll ever have!");
    _addSaleItem(2, '🍎 Apple', 1.50, "It's okay I guess");
    _addSaleItem(3, '🍔 Steamed Ham', 100,
        "Well, Seymour, you are an odd fellow, but I must say... you steam a good ham.");
  }

  void _addSaleItem(int id, String itemName, double price, String desc) {
    _saleItems.add(new SaleItem(id, itemName, price, desc));
  }

  void initializeSale() {
    _sale = new Sale();
  }

  List<SaleItem> getSaleItems() {
    return _saleItems;
  }

  List<LineItem> getCart() {
    if (_sale != null) {
      return _sale!.getCart();
    }

    return <LineItem>[];
  }

  bool addToCart(int id, int quantity) {
    if (_sale == null) {
      return false;
    }

    SaleItem selectedItem = _saleItems.firstWhere((curr) => curr.id == id,
        orElse: () => SaleItem.emptySaleItem);

    if (selectedItem == SaleItem.emptySaleItem) {
      return false;
    }

    return _sale!.addToCart(selectedItem, quantity);
  }

  bool removeFromCart(int id) {
    if (_sale == null) {
      return false;
    }

    SaleItem selectedItem = _saleItems.firstWhere((curr) => curr.id == id,
        orElse: () => SaleItem.emptySaleItem);

    print(selectedItem);

    if (selectedItem == SaleItem.emptySaleItem) {
      return false;
    }

    return _sale!.removeFromCart(selectedItem);
  }

  bool processPayment(String? creditNum) {
    if (creditNum == null || creditNum == "BAD") {
      return false;
    }

    return true;
  }

  double getSalePrice() {
    if (_sale == null) {
      return 0;
    }

    return _sale!.getPrice();
  }
}
