import 'lineItem.dart';
import 'saleitem.dart';

/**
 * Manages a sale for a single customer
 */
class Sale {
  final List<LineItem> _lineItems = <LineItem>[];

  List<LineItem> getCart() {
    return _lineItems;
  }

  bool addToCart(SaleItem item, int quantity) {
    LineItem duplicate = _lineItems.firstWhere(
        (curr) => curr.item.id == item.id,
        orElse: () => emptyLineItem);

    if (duplicate == emptyLineItem) {
      _lineItems.add(LineItem(item, quantity));
    } else {
      //Item already exists, add to the quantity
      duplicate.quantity += quantity;
    }

    //Sort cart
    _lineItems.sort((x, y) => x.item.id.compareTo(y.item.id));

    return true;
  }

  bool removeFromCart(SaleItem item) {
    _lineItems.removeWhere((lineItem) => lineItem.item.id == item.id);
    return true;
  }

  bool decrementCartItem(SaleItem item, int quantity) {
    LineItem duplicate = _lineItems.firstWhere(
        (curr) => curr.item.id == item.id,
        orElse: () => emptyLineItem);

    if (duplicate == emptyLineItem) {
      return false;
    } else {
      //Item exists, decrement the quantity
      if (duplicate.quantity - quantity > 0) {
        duplicate.quantity -= quantity;
      } else if (duplicate.quantity - quantity == 0) {
        _lineItems.remove(duplicate);
      } else {
        return false;
      }
    }

    //Sort cart
    _lineItems.sort((x, y) => x.item.id.compareTo(y.item.id));

    return true;
  }

  double getPrice() {
    double total = 0;

    for (LineItem lineItem in _lineItems) {
      total += lineItem.getSubtotal();
    }

    return total;
  }

  static LineItem emptyLineItem = LineItem(SaleItem.emptySaleItem, 0);
}
