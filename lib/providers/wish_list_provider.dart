import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addWishListData({
    required String wishListId,
    required String wishListName,
    required String wishListImage,
    required int wishListPrice,
    required int wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set({
      "wishListId": wishListId,
      "wishListName": wishListName,
      "wishListImage": wishListImage,
      "wishListPrice": wishListPrice,
      "wishListQuantity": wishListQuantity,
      "isWishList": true,
    });
  }

  List<ProductModel> wishList = [];
  void getWishListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot wishListValue = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    for (var element in wishListValue.docs) {
      ProductModel productModel = ProductModel(
        productID: element.get("wishListId"),
        productName: element.get("wishListName"),
        productImage: element.get("wishListImage"),
        productPrice: element.get("wishListPrice"),
        productQuantity: element.get("wishListQuantity"),
      );
      newList.add(productModel);
    }
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  void deleteWishItem(wishItemId) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishItemId)
        .delete();
  }
}
