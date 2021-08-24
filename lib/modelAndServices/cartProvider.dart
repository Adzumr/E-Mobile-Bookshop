import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant/main.dart';

import 'dishItem.dart';

class CartProvider with ChangeNotifier {
  List<DishItem> dishList = [];
  List<String> dishesName = [];
  double price = 0.0;
  void addDish({required DishItem dishItem}) {
    dishesName.add(dishItem.dishName);
    dishList.add(dishItem);
    price = price + dishItem.dishPrice;
    notifyListeners();
  }

  void removeDish({
    required int index,
    required double dishPrice,
  }) {
    dishList.removeAt(index);
    price = price - dishPrice;
    notifyListeners();
  }

  int get count {
    return dishList.length;
  }

  double get totalPrice {
    return price;
  }

  void placeOrder() async {
    try {
      await ordersReference.push().set({
        "Dishes": dishList.whereType<String>(),
        "Amount": totalPrice,
        "Name": FirebaseAuth.instance.currentUser!.displayName,
        "Email": FirebaseAuth.instance.currentUser!.email,
      }).then((value) {
        Fluttertoast.showToast(msg: "Order Placed!!!");
        dishList.clear();
        price = 0.0;
      }).timeout(Duration(seconds: 15), onTimeout: () {
        Fluttertoast.showToast(msg: "Service Timeout !!!");
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
