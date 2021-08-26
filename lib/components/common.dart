import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/pages/homeScreen.dart';
import 'package:my_restaurant/pages/profileScreen.dart';
import 'package:my_restaurant/pages/shoppingCart.dart';

import 'colors.dart';

AssetImage akaraImage = AssetImage("assets/akara.webp");
AssetImage friedRiceImage = AssetImage("assets/fried_rice.webp");
AssetImage jollofRiceImage = AssetImage("assets/jollof_rice.webp");
AssetImage moiMoiImage = AssetImage("assets/moi_moi.webp");
AssetImage poridgeYamImage = AssetImage("assets/poridge_yam.jpg");
AssetImage poundedYamImage = AssetImage("assets/pounded_yam.jpg");
AssetImage riceBeansImage = AssetImage("assets/rice_beans.webp");
AssetImage whiteRiceImage = AssetImage("assets/white_rice.webp");
AssetImage dishImage = AssetImage("assets/dish.webp");
AssetImage myPic = AssetImage("assets/sule.webp");
TextStyle orderHistoryStyle = TextStyle(
  fontSize: 20,
  color: secondaryColor,
  fontWeight: FontWeight.bold,
);
InputDecoration textFieldDecoration = InputDecoration(
  filled: true,
  fillColor: primaryColor,
  contentPadding: EdgeInsets.all(10),
  labelStyle: TextStyle(
    color: primaryColor,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: secondaryColor,
      width: 2,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: primaryColor,
      width: 1,
    ),
  ),
);

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Container(
        color: secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.idScreen, (route) => false);
              },
              leading: Icon(
                (Icons.home),
                size: 30,
                color: whiteColor,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: whiteColor),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, ShoppingCart.idScreen, (route) => false);
              },
              leading: Icon(
                (Icons.shopping_cart_outlined),
                color: whiteColor,
                size: 30,
              ),
              title: Text(
                "Cart",
                style: TextStyle(color: whiteColor),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Profile.idScreen, (route) => false);
              },
              leading: Icon(
                (Icons.person),
                color: whiteColor,
                size: 30,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: whiteColor),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: whiteColor,
                  onPrimary: secondaryColor,
                ),
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignIn.idScreen, (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
