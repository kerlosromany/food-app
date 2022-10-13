import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/view/screens/product_overview.dart';
import 'package:food_app/view/widgets/counter.dart';
import 'package:food_app/view/widgets/product_unit.dart';
import 'package:provider/provider.dart';

import '../../providers/review_cart_provider.dart';

class SingleProductWidget extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final String productId;
  final VoidCallback onTap;
  //final List<dynamic> productUnit;
  const SingleProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.price,
    required this.productId,
    //required this.productUnit,
  });

  // String unitData = "";
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 160,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xffd9dad9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: onTap,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$$price",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //   child: ProductUnitWidget(
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           builder: (context) {
                      //             return Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: widget.productUnit.map((e) {
                      //                 return ListTile(
                      //                   title: Text(e),
                      //                   onTap: () async {
                      //                     setState(() {
                      //                       unitData = e;
                      //                       print(unitData);
                      //                     });
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 );
                      //               }).toList(),
                      //             );
                      //           });
                      //     },
                      //     // ignore: unnecessary_null_comparison
                      //     title: unitData == "" ? firstValue : unitData,
                      //   ),
                      // ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Count(
                          productImage: image,
                          productName: title,
                          productPrice: price,
                          productId: productId,
                          //productUnit: unitData == "" ? firstValue : unitData,
                          //productQuantity: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
