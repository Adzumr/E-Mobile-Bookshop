import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:provider/provider.dart';

import 'homeScreen.dart';

class Profile extends StatefulWidget {
  static const idScreen = "accountScreen";
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      drawer: NavigationDrawer(),
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.idScreen, (route) => false);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: secondaryColor,
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: secondaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        title: Text(
                          firebaseAuth.currentUser!.displayName.toString(),
                          style: TextStyle(color: secondaryColor, fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        title: Text(
                          firebaseAuth.currentUser!.email.toString(),
                          style: TextStyle(color: secondaryColor, fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone, color: primaryColor),
                        title: Text(
                          "Phone Number",
                          style: TextStyle(color: secondaryColor, fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home, color: primaryColor),
                        title: Text(
                          "Address",
                          style: TextStyle(color: secondaryColor, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  onPrimary: whiteColor,
                  primary: primaryColor,
                ),
                onPressed: () {
                  firebaseAuth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignIn.idScreen, (route) => false);
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
