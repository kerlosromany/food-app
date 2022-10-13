// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class ReviewCartModel {
  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  int cartQuantity;
  //var cartUnit;
  ReviewCartModel({
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQuantity,
    //required this.cartUnit,
  });
}
