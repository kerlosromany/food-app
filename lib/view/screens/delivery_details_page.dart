import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/view/screens/add_delivery_address_page.dart';
import 'package:food_app/view/screens/payment_summary_page.dart';
import 'package:provider/provider.dart';

import '../widgets/single_delivery_item.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  late DeliveryAddressModel value;
  List<Widget> address = [
    // const SingleDeliveryItemWidget(
    //   address: "Qaliupia / Shoupra El Kheimal / Monti / street 8 ",
    //   addressType: "Home",
    //   number: "01225753674",
    //   title: "Kerolos Romany",
    // )
  ];

  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Details",
        ),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddDeliveryAddressScreen(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        child: MaterialButton(
          onPressed: () {
            // ignore: unnecessary_null_comparison
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AddDeliveryAddressScreen(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PaymentSummaryScreen(deliverAddressList: value),
                    ),
                  );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // ignore: unnecessary_null_comparison
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? const Text("Add new Address")
              : const Text("Payment Summary"),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Deliver To"),
            leading: Image.asset(
              'assets/location.png',
              height: 30,
            ),
          ),
          const Divider(height: 1),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? const Center(
                  child: Text("No Data"),
                )
              : Column(
                  children:
                      deliveryAddressProvider.getDeliveryAddressList.map((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItemWidget(
                      address:
                          "area, ${e.area} , street, ${e.street} , society, ${e.society} , PinCode, ${e.pinCode}",
                      addressType: e.addressType == "AddressTypes.Home"
                          ? "Home"
                          : e.addressType == "AddressTypes.Work"
                              ? "Work"
                              : "Other",
                      number: e.mobileNo,
                      title: "${e.firstName} ${e.lastName}",
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
