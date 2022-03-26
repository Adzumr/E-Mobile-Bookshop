import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/pages/homeScreen.dart';

import 'about.dart';

class Profile extends StatefulWidget {
  static const idScreen = "accountScreen";
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final firebaseAuth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.idScreen);
        return false;
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          drawer: NavigationDrawer(),
          backgroundColor: whiteColor,
          key: scaffoldKey,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        "Profile",
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
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
                  Expanded(
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Customers")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshots) {
                          if (!snapshots.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading...");
                          }
                          return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.stretch,
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            Icons.person,
                                            size: 30,
                                            color: primaryColor,
                                          ),
                                          title: Text(
                                            snapshots.data!["Name"],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.email,
                                            size: 30,
                                            color: primaryColor,
                                          ),
                                          title: Text(
                                            snapshots.data!
                                                .get("Email Address"),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.phone_android,
                                            size: 30,
                                            color: primaryColor,
                                          ),
                                          title: Text(
                                            snapshots.data!.get("Phone Number"),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // ListTile(
                                        //   leading: Icon(
                                        //     Icons.home,
                                        //     size: 30,
                                        //     color: primaryColor,
                                        //   ),
                                        //   title: Text(
                                        //     snapshots.data!
                                        //         .get("Delivery Address"),
                                        //     style: TextStyle(
                                        //       fontSize: 18,
                                        //       color: secondaryColor,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        // ),
                                        // ElevatedButton(
                                        //   onPressed: () {},
                                        //   child: Text("Update Profile"),
                                        // ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        await firebaseAuth.signOut();
                        await Fluttertoast.showToast(
                            msg: "Sign out successfully !!!");
                        await Navigator.pushNamedAndRemoveUntil(
                            context, SignIn.idScreen, (route) => false);
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (error) {
                        setState(() {
                          showSpinner = false;
                        });
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    },
                    child: Text("Log out"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
