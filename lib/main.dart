import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/onBoardingPages/signUp.dart';
import 'package:my_restaurant/pages/about.dart';
import 'package:my_restaurant/pages/homeScreen.dart';
import 'package:my_restaurant/pages/profileScreen.dart';
import 'package:my_restaurant/pages/shoppingCart.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
     
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: TextStyle(fontSize: 18),
              primary: secondaryColor,
              onPrimary: whiteColor,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? WelcomeScreen.idScreen
            : HomeScreen.idScreen,
        routes: {
          SignIn.idScreen: (context) => SignIn(),
          WelcomeScreen.idScreen: (context) => WelcomeScreen(),
          AboutMe.idScreen: (context) => AboutMe(),
          SignUp.idScreen: (context) => SignUp(),
          HomeScreen.idScreen: (context) => HomeScreen(),
          Profile.idScreen: (context) => Profile(),
          ShoppingCart.idScreen: (context) => ShoppingCart(),
        },
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String idScreen = "welcomeScreen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Fluttertoast.showToast(
          
          msg: "Exit");
        // Navigator.popAndPushNamed(context, HomeScreen.idScreen);
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Online Bookshop",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.school,
                    size: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignUp.idScreen, (route) => false);
                    },
                    child: Text("Register"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignIn.idScreen, (route) => false);
                    },
                    child: Text("Login"),
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
