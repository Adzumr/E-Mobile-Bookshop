import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:my_restaurant/modelAndServices/dishItem.dart';
import 'package:my_restaurant/pages/shoppingCart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const idScreen = "homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        
        // Navigator.popAndPushNamed(context, HomeScreen.idScreen);
        return false;
      },
      child: Scaffold(
        drawer: NavigationDrawer(),
        key: scaffoldKey,
        backgroundColor: whiteColor,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Bookshop",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ShoppingCart.idScreen, (route) => false);
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Items")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<String> dishImages = [
                            "assets/whiteboard.jpg",
                            "assets/ruler.jpg",
                            "assets/notebooks.jpg",
                            "assets/backpack.jpg",
                            "assets/pen.jpg",
                            "assets/stapler.jpg",
                            "assets/pencil-sharpener.jpg",
                            "assets/colors.jpg",
                            "assets/planner.jpg",
                            "assets/calculator.jpg",
                            "assets/maths_set.jpg",
                            "assets/sticky note.jpg",
                            "assets/folders.jpg",
                            "assets/eraser.jpg",
                          ];
                          var cart = Provider.of<CartProvider>(context);
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var disName =
                                    snapshot.data!.docs[index]["itemName"];
                                var disPrice =
                                    snapshot.data!.docs[index]["itemPrice"];
                                var dishQuantity =
                                    snapshot.data!.docs[index]["itemQuantity"];
                                return Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.all(15),
                                  child: GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Cart ?",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                  CloseButton()
                                                ],
                                              ),
                                              actions: [
                                                Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Name : " +
                                                            disName.toString(),
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: secondaryColor,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        "Price : NGN " +
                                                            disPrice.toString(),
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: secondaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  primaryColor),
                                                      onPressed: () async {
                                                        try {
                                                          if (dishQuantity <=
                                                              0) {
                                                            Fluttertoast.showToast(
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                msg:
                                                                    "Not Available. Try again later");
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            cart.addDish(
                                                              dishItem:
                                                                  ItemCart(
                                                                itemName:
                                                                    disName,
                                                                itemPrice:
                                                                    disPrice,
                                                              ),
                                                            );
                                                            Fluttertoast.showToast(
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                msg:
                                                                    "Added to cart successfully");
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        } catch (error) {
                                                          Fluttertoast
                                                              .showToast(
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            msg: error
                                                                .toString(),
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child: Text("Add"),
                                                    ),
                                                    SizedBox(height: 15)
                                                  ],
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Image.asset(
                                        dishImages[index],
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
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
