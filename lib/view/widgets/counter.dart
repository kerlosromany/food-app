import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  String productId;
  String productName;
  String productImage;
  int productPrice;
  int? productQuantity;
  //dynamic productUnit;
  Count({
    super.key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.productQuantity,
    //this.productUnit,
  });

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int counter = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        isTrue = value.get("isAdd");
                        counter = value.get("cartQuantity");
                      }),
                    }
                  else
                    {isTrue = false}
                }
            });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getAddAndQuantity();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);

    return isTrue
        ? Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (counter == 1) {
                      setState(() {
                        isTrue = false;
                      });

                      reviewCartProvider.deleteReviewCartData(widget.productId);
                    } else if (counter > 1) {
                      setState(() {
                        counter--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: counter,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                    color: Color(0xffd0b84c),
                  ),
                ),
                Text("$counter"),
                InkWell(
                  onTap: () {
                    setState(() {
                      counter++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartName: widget.productName,
                      cartImage: widget.productImage,
                      cartPrice: widget.productPrice,
                      cartQuantity: counter,
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xffd0b84c),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: TextButton(
              child: Text(
                "Add",
                style: TextStyle(color: primaryColor),
              ),
              onPressed: () {
                setState(() {
                  isTrue = true;
                });
                reviewCartProvider.addReviewCartData(
                  cartId: widget.productId,
                  cartName: widget.productName,
                  cartImage: widget.productImage,
                  cartPrice: widget.productPrice,
                  cartQuantity: counter,
                  //unitCart: widget.productUnit,
                );
              },
            ),
          );
  }
}
