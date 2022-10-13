import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/models/review_cart_model.dart';

class OrderItemWidget extends StatelessWidget {
  final ReviewCartModel reviewCartModel;
  const OrderItemWidget({super.key, required this.reviewCartModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        reviewCartModel.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            reviewCartModel.cartName,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            "\$ ${reviewCartModel.cartPrice}",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
      subtitle: Text(reviewCartModel.cartQuantity.toString()),
    );
  }
}
