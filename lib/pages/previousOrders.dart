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
              stream: FirebaseFirestore.instance
                  .collection("Available Dishes")
                  .snapshots(),
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
                        // Map<String, dynamic> userDetails =
                        //     snapshot.data!.docs[index]["User Detail"];
                        //
                        // Map<String, dynamic> dishDetail =
                        //     snapshot.data!.docs[index]["Dishes"];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  snapshot.data!.docs[index]["poridgeYam"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     ListTile(
                            //       title: Text(
                            //         "Dishes: "
                            //         "${dishDetail.keys}",
                            //         style: TextStyle(
                            //             color: secondaryColor, fontSize: 18),
                            //       ),
                            //       subtitle: Text(
                            //         "Dishes: "
                            //         "${userDetails.values}",
                            //         style: TextStyle(
                            //             color: secondaryColor, fontSize: 18),
                            //       ),
                            //       trailing: Text(
                            //         snapshot.data!.docs[index]["Total Amount"]
                            //             .toString(),
                            //       ),
                            //     )
                            //   ],
                            // ),
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
