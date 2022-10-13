import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../widgets/single_item.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late WishListProvider wishListProvider;
  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    showAlertDialog(BuildContext ctx, wishItemID) {
      Widget cancelButton() {
        return TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text("Cancel"),
        );
      }

      Widget continueButton() {
        return TextButton(
          onPressed: () {
            wishListProvider.deleteWishItem(wishItemID);
            Navigator.of(ctx).pop();
          },
          child: const Text("Continue"),
        );
      }

      AlertDialog alert = AlertDialog(
        title: const Text("Your Wish Item Product"),
        content: const Text("Do you want to delete this item ?"),
        actions: [
          cancelButton(),
          continueButton(),
        ],
      );
      showDialog(context: ctx, builder: (ctx) => alert);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wish List",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: wishListProvider.getWishList.isEmpty
          ? const Center(
              child: Text(
                "No Data",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            )
          : ListView.builder(
              itemCount: wishListProvider.getWishList.length,
              itemBuilder: (context, index) {
                ProductModel data = wishListProvider.getWishList[index];
                return SingleItemWidget(
                  isBool: true,
                  wishList: true,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productId: data.productID,
                  productQuantity: data.productQuantity,
                  delete: () {
                    showAlertDialog(context, data.productID);
                  },
                  //productUnit: data.productUnit,
                );
              },
            ),
    );
  }
}
