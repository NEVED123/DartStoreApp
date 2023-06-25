import 'dart:io';
import 'store.dart';
import 'saleitem.dart';
import 'lineItem.dart';

void main() {
  //Initialize store
  Store store = Store();

  print('\n==========================================================');
  print('''Welcome to the dart store! The store that aims to hit the target!
  To start adding an item to your cart, type the item id!''');
  print('==========================================================');

  store.initializeSale();

  bool checkOut = false;

  while (!checkOut) {
    print('\n----------------------------------------------------------');
    print('Items for sale:');

    for (SaleItem item in store.getSaleItems()) {
      int id = item.id;
      String name = item.itemName;
      double price = item.price;
      String desc = item.desc;
      print("(${id}) ${name} -- \$${price} -- ${desc}");
    }

    print('\nCart:');

    for (LineItem item in store.getCart()) {
      String name = item.item.itemName;
      int id = item.item.id;
      int quantity = item.quantity;
      double price = item.item.price;
      double subTotal = item.getSubtotal();
      print("(${id}) ${name}: ${quantity} x \$${price} ... \$${subTotal}");
    }

    print('\nTotal: \$${store.getSalePrice()}');

    print(
        "\nPut an 'r' before the id to remove from the cart. Enter 'c' to checkout.");

    stdout.write('\nItem: ');
    String? item = stdin.readLineSync();

    if (item == 'c') {
      checkOut = true;
    } else if (item?[0] == 'r') {
      int IdToRemove = int.tryParse(item?[1] ?? '-1') ?? -1;
      store.removeFromCart(IdToRemove);
    } else {
      int itemId = int.tryParse(item ?? '-1') ?? -1;

      stdout.write('\nQuantity: ');
      int quantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

      if (!store.addToCart(itemId, quantity)) {
        print(
            '\nCould not add item to sale - Must add at least one of an existing item');
      }
    }
  }

  //User is no longer picking items, time to checkout

  bool finished = false;

  while (!finished) {
    print('\nYour total is \$${store.getSalePrice()}.');
    stdout.write('Please enter your credit card number: ');
    String? creditNum = stdin.readLineSync();

    if (store.processPayment(creditNum)) {
      print('\nPayment complete! Thank you for shopping at the dart store!');
      finished = true;
    } else {
      print('Invalid credit card number. Please try again.');
    }
  }
}
