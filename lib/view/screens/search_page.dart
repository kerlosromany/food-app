import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/models/product_model.dart';

import '../widgets/single_item.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel> searchedList;
  const SearchScreen({super.key, required this.searchedList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

enum SignInCharacter { lowToHigh, highToLow, alphapetically }

class _SearchScreenState extends State<SearchScreen> {
  SignInCharacter _character = SignInCharacter.alphapetically;
  String query = "";
  List<ProductModel> itemSearch(String query) {
    List<ProductModel> searchFood = widget.searchedList.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _itemSearch = itemSearch(query);
    bottomSheet() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  "Sort By",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile(
                value: SignInCharacter.lowToHigh,
                groupValue: _character,
                title: const Text(
                  "Low To High",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onChanged: (val) {
                  setState(() {
                    _character = val!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                value: SignInCharacter.highToLow,
                title: const Text(
                  "High To Low",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                groupValue: _character,
                onChanged: (val) {
                  setState(() {
                    _character = val!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                value: SignInCharacter.alphapetically,
                title: const Text(
                  "Alphapetically",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                groupValue: _character,
                onChanged: (val) {
                  setState(() {
                    _character = val!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        title: Text(
          "Search",
          style: TextStyle(color: textColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                bottomSheet();
              },
              icon: const Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Items"),
          ),
          const SizedBox(height: 15),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xffc2c2c2),
                filled: true,
                suffixIcon: const Icon(Icons.search),
                hintText: "Search here in the store",
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: _itemSearch.map(
              (productData) {
                return SingleItemWidget(
                  isBool: false,
                  productImage: productData.productImage,
                  productName: productData.productName,
                  productPrice: productData.productPrice,
                  productId: productData.productID,
                  
                  //productUnit: "69",
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
