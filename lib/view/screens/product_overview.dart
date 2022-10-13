import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/view/screens/review_cart.dart';
import 'package:provider/provider.dart';

import '../../providers/wish_list_provider.dart';
import '../widgets/counter.dart';

enum SignInCharacter { fill, outline }

class ProductOverViewScreen extends StatefulWidget {
  final String? productName;
  final String? productImage;
  final String? productId;
  final int? productPrice;
  //List<dynamic> productUnit;
  ProductOverViewScreen(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productId,
      //required this.productUnit
      });

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {

  SignInCharacter _character = SignInCharacter.fill;

  Widget bottomNavBarWidget({
    required Color iconColor,
    required Color backGroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backGroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;
  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      wishListBool = value.get("isWishList");
                    }),
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text(
          "Product Details",
          style: TextStyle(color: textColor),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          bottomNavBarWidget(
              iconColor: Colors.grey,
              backGroundColor: textColor,
              color: Colors.white70,
              title: "Add To WishList",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                    wishListId: widget.productId as String,
                    wishListName: widget.productName as String,
                    wishListImage: widget.productImage as String,
                    wishListPrice: widget.productPrice as int,
                    wishListQuantity: 2,
                  );
                } else {
                  wishListProvider.deleteWishItem(widget.productId);
                }
              }),
          bottomNavBarWidget(
            iconColor: Colors.white70,
            backGroundColor: primaryColor,
            color: textColor,
            title: "Go To Cart",
            iconData: Icons.shop_outlined,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ReviewCart()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName ?? "Unknown"),
                    subtitle: Text("\$${widget.productPrice}"),
                  ),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(40),
                    child: Image.network(widget.productImage ?? ""),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 3,
                          ),
                          Radio(
                            value: SignInCharacter.fill,
                            groupValue: _character,
                            onChanged: (value) {
                              setState(() {
                                _character = value!;
                              });
                            },
                            activeColor: Colors.green[700],
                          )
                        ],
                      ),
                      const Text("\$50"),
                      Count(
                        productImage: widget.productImage as String,
                        productName: widget.productName as String,
                        productPrice: widget.productPrice as int,
                        productId: widget.productId as String,
                        productQuantity: 1,
                        //productUnit: widget.productUnit,
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About this product",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "About this product",
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
