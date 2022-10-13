import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/view/screens/delivery_details_page.dart';
import 'package:food_app/view/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  const ReviewCart({super.key});

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    showAlertDialog(BuildContext ctx, cartID) {
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
            reviewCartProvider.deleteReviewCartData(cartID);
            Navigator.of(ctx).pop();
          },
          child: const Text("Continue"),
        );
      }

      AlertDialog alert = AlertDialog(
        title: const Text("Cart Product"),
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
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text(
          "Review Cart",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getreviewCartDataList.isEmpty
          ? const Center(
              child: Text(
                "No Data",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getreviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getreviewCartDataList[index];
                return SingleItemWidget(
                  isBool: true,
                  wishList: false,
                  productImage: data.cartImage,
                  productName: data.cartName,
                  productPrice: data.cartPrice,
                  productId: data.cartId,
                  productQuantity: data.cartQuantity,
                  delete: () {
                    showAlertDialog(context, data.cartId);
                  },
                  //productUnit: data.cartUnit,
                );
              },
            ),
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: Text(
          "\$ ${reviewCartProvider.getTotalPrice()}",
          style: TextStyle(color: Colors.green[900]),
        ),
        trailing: Container(
          width: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: MaterialButton(
            child: const Text("Submit"),
            onPressed: () {
              if (reviewCartProvider.getreviewCartDataList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("No Cart Data Found"),
                ));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>  DeliveryDetailsScreen()));
              }
            },
          ),
        ),
      ),
    );
  }
}
