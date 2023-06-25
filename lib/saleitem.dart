class SaleItem {
  final String itemName;
  final double price;
  final String desc;
  final int id;

  const SaleItem(this.id, this.itemName, this.price, this.desc);

  @override
  String toString() {
    return 'Item: ${itemName}, Price: ${price}, Description: ${desc}';
  }

  static SaleItem emptySaleItem = SaleItem(-1, '', 0, '');
}
