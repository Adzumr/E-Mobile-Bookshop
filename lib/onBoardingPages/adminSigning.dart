import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/pages/previousOrders.dart';

class AdminSignIn extends StatefulWidget {
  static const idScreen = "adminLoginScreen";
  const AdminSignIn({Key? key}) : super(key: key);

  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final _formKey = GlobalKey<FormState>();
  String emailAddress = "";
  String resetEmail = "";
  String password = "";
  String error = "";
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, SignIn.idScreen, (route) => false);
            },
            icon: Icon(
              Icons.person,
              color: secondaryColor,
            ),
            label: Text(
              "Customer Access",
              style: TextStyle(color: secondaryColor, fontSize: 18),
            ),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Restaurant",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Admin",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Email" : null,
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value;
                          print(emailAddress);
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFieldDecoration.copyWith(
                          filled: false, labelText: "Admin Email Address"),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? "Password must be at least 6 character long"
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                          print(password);
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: textFieldDecoration.copyWith(
                          filled: false, labelText: "Admin Password"),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signInUser(context);
                        } else {
                          setState(() {
                            error = "Please provide valid email address";
                          });
                        }
                      },
                      child: Text("Admin Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void signInUser(BuildContext context) async {
    try {
      if (emailAddress == "admin001@gmail.com") {
        setState(() {
          showSpinner = true;
        });

        await _firebaseAuth
            .signInWithEmailAndPassword(
          email: emailAddress.trim(),
          password: password.trim(),
        )
            .then((value) {
          setState(() {
            showSpinner = false;
          });
          Fluttertoast.showToast(msg: "Logged In Successfully");
          Navigator.pushNamedAndRemoveUntil(
              context, PreviousOrders.idScreen, (route) => false);
        }).timeout(Duration(seconds: 15), onTimeout: () {
          setState(() {
            showSpinner = false;
          });
          Fluttertoast.showToast(msg: "Service Timeout!!!");
        }).catchError((onError) {
          setState(() {
            showSpinner = false;
          });
          Fluttertoast.showToast(msg: onError.toString());
        });
      }
    } catch (error) {
      setState(() {
        showSpinner = false;
      });
      _firebaseAuth.signOut();
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
