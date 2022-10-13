import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;
  List<ProductModel> allProducts = [];

  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productName: element.get("productName"),
      productImage: element.get("productImage"),
      productPrice: element.get("productPrice"),
      productID: element.get("productId"),
      //productUnit: element.get("productUnit"),
    );

    allProducts.add(productModel);
  }

  ///////////////// HerbsProduct ////////////////
  List<ProductModel> herbsProductList = [];

  fetchHerbsProductsData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("herbsProduct").get();
    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel);
    }
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductsDataList {
    return herbsProductList;
  }

  ///////////////// FruitsProduct ////////////////
  List<ProductModel> fruitsProductList = [];

  fetchfruitsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("fruitsProducts").get();
    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel);
    }
    fruitsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getfruitsProductDataList {
    return fruitsProductList;
  }

  ///////////////// rootsProduct ////////////////
  List<ProductModel> rootsProductList = [];

  fetchRootsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("rootsProducts").get();
    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel);
    }
    rootsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getrootsProductDataList {
    return rootsProductList;
  }


  List<ProductModel> get getallProductDataList {
    return allProducts;
  }
}
