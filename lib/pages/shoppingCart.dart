import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:provider/provider.dart';

import 'about.dart';
import 'homeScreen.dart';

class ShoppingCart extends StatefulWidget {
  static const idScreen = "cartScreen";
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    bool showSpinner = false;
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.idScreen);
        return false;
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.idScreen, (route) => false);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Cart (${cart.itemList.length})",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AboutMe.idScreen, (route) => false);
                  },
                  icon: Icon(
                    Icons.info,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cart.itemList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                cart.itemList[index].itemName,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                "NGN: " +
                                    cart.itemList[index].itemPrice.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: TextButton(
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  cart.removeDish(
                                    index: index,
                                    itemPrice: cart.itemList[index].itemPrice,
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Checkout ?"),
                                  CloseButton(),
                                ],
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (cart.itemList.length != 0) {
                                        try {
                                          cart.placeOrder();
                                          Fluttertoast.showToast(
                                            msg: "Order Placed Successfully!!!",
                                            toastLength: Toast.LENGTH_LONG,
                                          );
                                          await Navigator
                                              .pushNamedAndRemoveUntil(
                                                  context,
                                                  HomeScreen.idScreen,
                                                  (route) => false);
                                        } catch (error) {
                                          await Fluttertoast.showToast(
                                            msg: error.toString(),
                                          );
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                                msg: "Cart is Empty")
                                            .then((value) =>
                                                Navigator.pop(context));
                                      }
                                    },
                                    child: Text("Yes"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                    style: ElevatedButton.styleFrom(
                                        primary: primaryColor),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Checkout"),
                        Text("Total: " + cart.totalPrice.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
