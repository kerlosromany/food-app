import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/view/screens/product_overview.dart';
import 'package:food_app/view/screens/review_cart.dart';
import 'package:food_app/view/screens/search_page.dart';
import 'package:food_app/view/widgets/drawer.dart';
import 'package:food_app/view/widgets/single_product.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductProvider productProvider;
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchHerbsProductsData();
    productProvider.fetchfruitsProductData();
    productProvider.fetchRootsProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffd6d738),
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xffd4d181),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SearchScreen(
                              searchedList:
                                  productProvider.getallProductDataList,
                            )));
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 22,
                    color: Colors.black,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ReviewCart()));
              },
              child: const CircleAvatar(
                radius: 17,
                backgroundColor: Color(0xffd4d181),
                child: Icon(
                  Icons.shop_outlined,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: HeaderDrawerWidget(userProvider: userProvider),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: Colors.red,
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi0Xg-k622Sbztlrb-L1o1CAla3zCbVc2lUw&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 120),
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Vegi",
                                style: TextStyle(color: Colors.white, shadows: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.green,
                                    offset: Offset(3, 3),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          const Text(
                            "30% off",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "on all vegetables products",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
            const SizedBox(height: 5),
            _buildHerbsProducts(context),
            const SizedBox(height: 5),
            _buildFruitProducts(context),
            const SizedBox(height: 5),
            _buildRootProducts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHerbsProducts(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Herbs Seasonings",
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(
                          searchedList:
                              productProvider.getHerbsProductsDataList,
                            
                        )));
              },
              child: const Text(
                "view all",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getHerbsProductsDataList.map(
              (herbsProductsData) {
                return SingleProductWidget(
                  image: herbsProductsData.productImage,
                  title: herbsProductsData.productName,
                  price: herbsProductsData.productPrice,
                  productId: herbsProductsData.productID,
                  //productUnit: herbsProductsData.productUnit as List<dynamic>,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductOverViewScreen(
                          productPrice: herbsProductsData.productPrice,
                          productName: herbsProductsData.productName,
                          productImage: herbsProductsData.productImage,
                          productId: herbsProductsData.productID,
                          //productUnit: herbsProductsData.productUnit as List<dynamic>,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFruitProducts(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Fresh Fruits",
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(
                        searchedList:
                            productProvider.getfruitsProductDataList)));
              },
              child: const Text(
                "view all",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getfruitsProductDataList.map(
              (fruitProductData) {
                return SingleProductWidget(
                  image: fruitProductData.productImage,
                  title: fruitProductData.productName,
                  price: fruitProductData.productPrice,
                  productId: fruitProductData.productID,
                  //productUnit: fruitProductData.productUnit as List<dynamic>,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductOverViewScreen(
                          productPrice: fruitProductData.productPrice,
                          productName: fruitProductData.productName,
                          productImage: fruitProductData.productImage,
                          productId: fruitProductData.productID,
                          //productUnit: fruitProductData.productUnit as List<dynamic>,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRootProducts(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Roots",
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(
                        searchedList:
                            productProvider.getrootsProductDataList)));
              },
              child: const Text(
                "view all",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider.getrootsProductDataList.map(
              (rootProductData) {
                return SingleProductWidget(
                  price: rootProductData.productPrice,
                  image: rootProductData.productImage,
                  title: rootProductData.productName,
                  productId: rootProductData.productID,
                  //productUnit: rootProductData.productUnit as List<dynamic>,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductOverViewScreen(
                          productName: rootProductData.productName,
                          productImage: rootProductData.productImage,
                          productPrice: rootProductData.productPrice,
                          productId: rootProductData.productID,
                          //productUnit: rootProductData.productUnit as List<dynamic>,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
