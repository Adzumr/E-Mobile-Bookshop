import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/onBoardingPages/signUp.dart';
import 'package:my_restaurant/pages/homeScreen.dart';

class SignIn extends StatefulWidget {
  static const idScreen = "signInScreen";
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: whiteColor,
      //   actions: [
      //     TextButton.icon(
      //       onPressed: () {
      //         Navigator.pushNamedAndRemoveUntil(
      //             context, AdminSignIn.idScreen, (route) => false);
      //       },
      //       icon: Icon(
      //         Icons.person,
      //         color: secondaryColor,
      //       ),
      //       label: Text(
      //         "Admin Access",
      //         style: TextStyle(color: secondaryColor, fontSize: 18),
      //       ),
      //     ),
      //   ],
      // ),
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
                      "My Restaurant",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign In",
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
                          _signInUser(context);
                        } else {
                          setState(() {
                            error = "Please provide valid email address";
                          });
                        }
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Reset Password",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Enter your registered email address:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) => value!.isNotEmpty
                                          ? "Enter your email address"
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          resetEmail = value;
                                        });
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          filled: false, labelText: "Address"),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email: resetEmail);
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Reset link has been sent");
                                            } catch (error) {
                                              Fluttertoast.showToast(
                                                  msg: error.toString());
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text(
                                            "Send",
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                            context, SignUp.idScreen, (route) => false);
                      },
                      child: Text(
                        "Don't have an Account?",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
  Future _signInUser(BuildContext context) async {
    try {
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
            context, HomeScreen.idScreen, (route) => false);
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
    } catch (error) {
      setState(() {
        showSpinner = false;
      });
      _firebaseAuth.signOut();
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
