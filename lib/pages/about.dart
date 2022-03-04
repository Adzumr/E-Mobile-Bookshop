import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/pages/homeScreen.dart';

class AboutMe extends StatelessWidget {
  static const idScreen = "aboutScreen";
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.idScreen);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.idScreen, (route) => false);
                        },
                      ),
                      Text(
                        "Online Bookshop",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: primaryColor,
                        ),
                      ),
                      Opacity(
                        opacity: 0.00,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "An online bookshop is an e-commerce mobile application for selling books and other writing and reading materials online. The project “design and implementation of an online bookshop” aims at providing a platform that allows a customer to search and purchase from the bookshop online. Among its functionalities include catalog management, customer accounts, order management, and shopping cart. It provides the user with a catalog to browse different items available for purchase in the bookshop. Through the App a customer can search for a books and other writing and reading materials, add to the shopping cart and finally purchase using debit or credit card like Master card, Visa card or Verve cards.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "The system is implemented using Google Firebase as the backend database, and mobile application as the front end to the client. Making use of the following tools: Flutter, Firebase, Cloud Firestore, a user friendly, flexible and reliable mobile application for online bookshop was developed.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
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
