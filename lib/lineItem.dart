import 'saleitem.dart';

class LineItem {
  late SaleItem item;
  late int quantity;

  LineItem(SaleItem item, int quantity) {
    this.item = item;
    this.quantity = quantity;
  }

  @override
  String toString() {
    return 'Item: ${item.itemName}, Quantity: ${quantity}';
  }

  double getSubtotal() {
    return item.price * quantity;
  }
}
