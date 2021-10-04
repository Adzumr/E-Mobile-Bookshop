import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:my_restaurant/modelAndServices/userProvider.dart';
import 'package:my_restaurant/onBoardingPages/adminSigning.dart';
import 'package:my_restaurant/onBoardingPages/signIn.dart';
import 'package:my_restaurant/onBoardingPages/signUp.dart';
import 'package:my_restaurant/pages/about.dart';
import 'package:my_restaurant/pages/homeScreen.dart';
import 'package:my_restaurant/pages/previousOrders.dart';
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

DatabaseReference userReference =
    FirebaseDatabase.instance.reference().child("Users");
DatabaseReference nodMCUReference =
    FirebaseDatabase.instance.reference().child("Nod MCU Orders");
DatabaseReference ordersReference =
    FirebaseDatabase.instance.reference().child("Orders");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
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
            ? SignIn.idScreen
            : HomeScreen.idScreen,
        routes: {
          SignIn.idScreen: (context) => SignIn(),
          AboutMe.idScreen: (context) => AboutMe(),
          AdminSignIn.idScreen: (context) => AdminSignIn(),
          SignUp.idScreen: (context) => SignUp(),
          HomeScreen.idScreen: (context) => HomeScreen(),
          Profile.idScreen: (context) => Profile(),
          ShoppingCart.idScreen: (context) => ShoppingCart(),
          PreviousOrders.idScreen: (context) => PreviousOrders(),
        },
      ),
    );
  }
}
