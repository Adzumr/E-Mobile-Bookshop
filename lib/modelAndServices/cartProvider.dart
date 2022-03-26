import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dishItem.dart';

class CartProvider with ChangeNotifier {
  List<ItemCart> itemList = [];
  double price = 0.0;
  void addDish({required ItemCart dishItem}) {
    itemList.add(dishItem);
    price = price + dishItem.itemPrice;
    notifyListeners();
  }

  void removeDish({
    required int index,
    required var itemPrice,
  }) {
    itemList.removeAt(index);
    price = price - itemPrice;
    notifyListeners();
  }

  int get count {
    return itemList.length;
  }

  double get totalPrice {
    return price;
  }

  var userID = FirebaseAuth.instance.currentUser!.uid;
   void placeOrder() async {
    print("Cart Total Amount is :" + price.toString());
    print("Cart Total Items is :" + count.toString());
    var itemMap = {};
    var userInfo = {
      "Name": FirebaseAuth.instance.currentUser!.displayName,
      "Email Address": FirebaseAuth.instance.currentUser!.email,
    };
    itemList.forEach((item) => itemMap[item.itemName] = item.itemPrice);
  
    try {
      await FirebaseFirestore.instance.collection("Orders").add({
        "Dishes": itemMap,
        "Amount": price,
        "User": userInfo,
      });
      itemList.clear();
      price = 0.0;
  
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
