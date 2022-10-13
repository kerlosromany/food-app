class ProductModel {
  final String productName;
  final String productImage;
  final String productID;
  final int productPrice;
  final int? productQuantity;
  //final List<dynamic>? productUnit;

  ProductModel(
      {required this.productID,
      required this.productName,
      required this.productImage,
      required this.productPrice,
      //this.productUnit,
      this.productQuantity});
}
