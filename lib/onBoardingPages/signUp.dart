import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/main.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/pages/homeScreen.dart';

class SignUp extends StatefulWidget {
  static const String idScreen = "signUpScreen";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phoneNumber = "";
  String emailAddress = "";
  String password = "";
  String error = "";
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, WelcomeScreen.idScreen);
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
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
                        "Registration",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) => value!.length < 2
                            ? "Must be at least 2 characters"
                            : null,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                            print(name);
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration: textFieldDecoration.copyWith(
                            filled: false, labelText: "Name"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) =>
                            value!.length < 10 ? "Enter Phone Number" : null,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                            print(phoneNumber);
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: textFieldDecoration.copyWith(
                            filled: false, labelText: "Phone Number"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter valid Email" : null,
                        onChanged: (value) {
                          setState(() {
                            emailAddress = value;
                            print(emailAddress);
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldDecoration.copyWith(
                            filled: false, labelText: "Email Address"),
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
                            filled: false, labelText: "Password"),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            registerNewUser(context);
                          } else {
                            setState(() {
                              error = "Please provide valid email address";
                            });
                          }
                        },
                        child: Text("Register"),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, SignIn.idScreen, (route) => false);
                        },
                        child: Text(
                          "Already have an Account?",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future registerNewUser(BuildContext context) async {
    try {
      setState(() {
        showSpinner = true;
      });
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress.trim(),
        password: password.trim(),
      );
      _firebaseAuth.currentUser!.updateDisplayName(name);
      _firebaseAuth.currentUser!.updateEmail(emailAddress);

      var userID = _firebaseAuth.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Customers").doc(userID).set({
        "Name": name.trim(),
        "Email Address": emailAddress.trim(),
        "Phone Number": phoneNumber.trim(),
      }).then((value) async {
        await Fluttertoast.showToast(msg: "Register Successfully");
        setState(() {
          showSpinner = false;
        });

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.idScreen, (route) => false);
      }).timeout(Duration(seconds: 10), onTimeout: () {
        setState(() {
          showSpinner = false;
        });
        Fluttertoast.showToast(msg: "Service Timeout!!!");
      }).catchError((onError) {
        Fluttertoast.showToast(msg: onError.toString());
      });
    } catch (error) {
      setState(() {
        showSpinner = false;
      });
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<GlobalKey<FormState>>('_formKey', _formKey));
  }
}
