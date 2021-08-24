import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/components/common.dart';
import 'package:my_restaurant/modelAndServices/cartProvider.dart';
import 'package:my_restaurant/modelAndServices/dishItem.dart';
import 'package:my_restaurant/pages/about.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const idScreen = "homeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      key: scaffoldKey,
      backgroundColor: whiteColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      "My Restaurant",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AboutMe.idScreen, (route) => false);
                      },
                      icon: Icon(
                        Icons.info,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        DishCard(
                          image: akaraImage,
                          dishName: "Akara",
                          price: 350,
                        ),
                        DishCard(
                          image: friedRiceImage,
                          dishName: "Fried Rice",
                          price: 500,
                        ),

                        DishCard(
                          price: 500,
                          dishName: "Jollof Rice",
                          image: jollofRiceImage,
                        ),
                        DishCard(
                          price: 300,
                          dishName: "Moi Moi",
                          image: moiMoiImage,
                        ),
                        // Porridge Yam
                        DishCard(
                          price: 500,
                          dishName: "Yam Porridge",
                          image: poridgeYamImage,
                        ),
                        DishCard(
                          price: 500,
                          dishName: "Pounded Yam",
                          image: poundedYamImage,
                        ),
                        DishCard(
                          price: 500,
                          dishName: "Rice & Beans",
                          image: riceBeansImage,
                        ),
                        DishCard(
                          price: 400,
                          dishName: "White Rice",
                          image: whiteRiceImage,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  DishCard({
    required this.price,
    required this.dishName,
    required this.image,
  });
  final String dishName;
  final double price;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Card(
      elevation: 4,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add to Cart"),
                      CloseButton(),
                    ],
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(
                          "Dish: " + dishName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Price: " + price.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Image(image: akaraImage),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          cart.addDish(
                            dishItem:
                                DishItem(dishName: dishName, dishPrice: price),
                          );
                          Fluttertoast.showToast(
                              msg: "Added to cart successfully");
                          Navigator.pop(context);
                        },
                        child: Text("Add"),
                      )
                    ],
                  ),
                );
              });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
