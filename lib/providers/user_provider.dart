import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    required String userEmail,
    required String userName,
    required String userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set(
      {
        "email": userEmail,
        "name": userName,
        "userUid": currentUser.uid,
        "image": userImage,
      },
    );
  }

  late UserModel currentData;
  void getUserData() async {
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      UserModel userModel = UserModel(
        userEmail: value.get("email"),
        userImage: value.get("image"),
        userName: value.get("name"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}
