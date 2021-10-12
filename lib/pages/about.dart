import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_restaurant/components/colors.dart';
import 'package:my_restaurant/pages/homeScreen.dart';

class AboutMe extends StatelessWidget {
  static const idScreen = "aboutScreen";
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "About Me",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: secondaryColor,
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
                Image.asset(
                  "assets/adzumr.jpg",
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(
                  "I am  Umar Abdulaziz Jada with Registration Number 15/38979U/2,"
                  " department of Computer and Communications Engineering, ATBU Bauchi."
                  " I'm passionate about inspiring people to "
                  "drive social impact so that together "
                  "we can make the world a better place."
                  " In my years of experience, "
                  "I have worked with a diverse group of"
                  " individuals to tell compelling stories"
                  " that help in making a sustainable and "
                  "lasting impact through shaping "
                  "communication using visual design",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.phoneAlt,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 10),
                        SelectableText(
                          "+2348130762880",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.twitter,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 10),
                        SelectableText(
                          "@adzumrjada",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 10),
                        SelectableText(
                          "adzumrjada@gmail.com",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.linkedin,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 10),
                        SelectableText(
                          "linkedin.com/in/adzumrjada",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
