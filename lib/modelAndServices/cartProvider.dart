import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant/main.dart';

import 'dishItem.dart';

class CartProvider with ChangeNotifier {
  List<DishItem> dishList = [];
  double price = 0.0;
  void addDish({required DishItem dishItem}) {
    dishList.add(dishItem);
    price = price + dishItem.dishPrice;
    notifyListeners();
  }

  static void retrieveOrders() {}
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
    var dishMap = {};
    var userInfo = {
      "Name": FirebaseAuth.instance.currentUser!.displayName,
      "Email Adrdess": FirebaseAuth.instance.currentUser!.email,
      // "Delivery Address": deliveryAddress,
    };
    dishList.forEach((dish) => dishMap[dish.dishName] = dish.dishPrice);
    Map orderPlaced = {
      "Dishes": dishMap,
      "Amount": price,
      "User": userInfo,
    };
    Map nodMCU = {
      "Dishes": dishMap,
      "Amount": price,
    };

    try {
      await nodMCUReference.set(nodMCU);
      await ordersReference.push().set(orderPlaced).then((value) {
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
