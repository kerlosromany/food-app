import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/review_cart_provider.dart';
import 'counter.dart';

class SingleItemWidget extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  String productId;
  int productPrice;
  int? productQuantity;
  VoidCallback? delete;
  bool? wishList = false;
  //dynamic productUnit;
  SingleItemWidget({
    super.key,
    required this.isBool,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    this.productQuantity,
    this.delete,
    this.wishList,
    //this.productUnit,
  });

  @override
  State<SingleItemWidget> createState() => _SingleItemWidgetState();
}

class _SingleItemWidgetState extends State<SingleItemWidget> {

  @override
  Widget build(BuildContext context) {

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    // widget.productUnit.firstWhere((element) {
    //   setState(() {
    //     firstValue = element;
    //   });
    //   return true;
    // });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: Image.network(
                    widget.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 90,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$ ${widget.productPrice}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text("50 Gram"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            title: Text("500 Gram"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            title: Text("1 Kg"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "50 g",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const Text(
                              "50 gram",
                              style: TextStyle(color: Colors.grey),
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: widget.isBool == false
                      ? const EdgeInsets.symmetric(horizontal: 15, vertical: 30)
                      : null,
                  height: 100,
                  child: widget.isBool == false
                      ? Count(
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          productId: widget.productId,
                          //productUnit: unitData == "" ? firstValue : unitData,
                          //productQuantity: 1,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: widget.delete,
                                child: const Icon(Icons.delete,
                                    size: 25, color: Colors.black54),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              widget.wishList == false
                                  ? Count(
                                      productImage: widget.productImage,
                                      productName: widget.productName,
                                      productPrice: widget.productPrice,
                                      productId: widget.productId,
                                      //productUnit: unitData == "" ? firstValue : unitData,
                                      //productQuantity: 1,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : const Divider(height: 1, color: Colors.black54),
      ],
    );
  }
}
