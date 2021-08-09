import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AssistantModel {
  userInfo() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    String emailAddress;
    String name;
    String phoneNumber;
    String deliveryAddress;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(firebaseUser.uid)
          .get()
          .then((snapShot) {
        name = snapShot.get("name");
        phoneNumber = snapShot.get("phoneNumber");
        emailAddress = snapShot.get("email");
        deliveryAddress = snapShot.get("deliveryAddress");
        print(name);
        print(phoneNumber);
        print(emailAddress);
        print(deliveryAddress);
      }).catchError((onError) {
        Fluttertoast.showToast(msg: onError.toString());
      });
  }

  Future placeOrder({required String dishName}) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection("Orders").add({
        'Name': user!.displayName,
        'dish': dishName,
        'price': "500",
        // 'Phone Number': userCurrentInfo!.phoneNumber,
        // 'Delivery Address': userCurrentInfo!.deliveryAddress,
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
