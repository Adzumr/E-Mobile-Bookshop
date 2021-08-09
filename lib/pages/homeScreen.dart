import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/modelAndServices/assistantModel.dart';
import 'package:my_restaurant/pages/about.dart';

class HomeScreen extends StatefulWidget {
  static const idScreen = "homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AssistantModel assistantModel = AssistantModel();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      key: scaffoldKey,
      backgroundColor: whiteColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "My Restaurant",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AboutMe.idScreen, (route) => false);
                      },
                      icon: Icon(
                        Icons.info,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Akara");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: akaraImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Akara",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Fried Rice");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: friedRiceImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Fried Rice",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Jollof Rice");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: jollofRiceImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Jollof Rice",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Moi Moi");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: moiMoiImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Moi Moi",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Porridge Yam");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: poridgeYamImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Porridge Yam",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Pounded Yam");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: poundedYamImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Pounded Yam",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "Rice and Beans");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: riceBeansImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "Rice Beans",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: GestureDetector(
                            onTap: () {
                              _placeOrder(dishName: "White Rice");
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: whiteRiceImage,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Text(
                                "White Rice",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _placeOrder({required String dishName}) async {
    try {
      setState(() {
        showSpinner = true;
      });
      final firebaseUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("Orders").add({
        'Name': FirebaseAuth.instance.currentUser!.displayName,
        'dish': dishName,
        'price': "500",
        'Phone Number': await FirebaseFirestore.instance
            .collection("Users")
            .doc(firebaseUser!.uid)
            .get()
            .then((value) {
          return value.get("phoneNumber");
        }),
        'Delivery Address': await FirebaseFirestore.instance
            .collection("Users")
            .doc(firebaseUser.uid)
            .get()
            .then((value) {
          return value.get("deliveryAddress");
        }),
      });
      Fluttertoast.showToast(msg: "Order placed ");
      setState(() {
        showSpinner = false;
      });
    } catch (error) {
      setState(() {
        showSpinner = false;
      });
      FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
