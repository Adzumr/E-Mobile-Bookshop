import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/onBoardingPages/adminSigning.dart';

class PreviousOrders extends StatefulWidget {
  static const idScreen = "previousOrderScreen";
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  _PreviousOrdersState createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AdminSignIn.idScreen, (route) => false);
                  Fluttertoast.showToast(msg: "Logout!");
                });
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
            },
            child: Text("Logout"),
          )
        ],
        title: Text(
          "Placed Orders",
          style: TextStyle(color: whiteColor, fontSize: 18),
        ),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Orders").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["Name"].toString(),
                                  style: TextStyle(
                                      color: secondaryColor, fontSize: 18),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["dish"].toString(),
                                  style: TextStyle(
                                      color: secondaryColor, fontSize: 18),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["price"]
                                      .toString(),
                                  style: TextStyle(
                                      color: secondaryColor, fontSize: 18),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["Phone Number"]
                                      .toString(),
                                  style: TextStyle(
                                      color: secondaryColor, fontSize: 18),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["Delivery Address"]
                                      .toString(),
                                  style: TextStyle(
                                      color: secondaryColor, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }

                return Text("");
              },
            )),
      ),
    );
  }
}
