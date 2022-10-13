import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/view/widgets/my_google_pay.dart';
import 'package:food_app/view/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../widgets/single_delivery_item.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  const PaymentSummaryScreen({super.key, required this.deliverAddressList});

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

enum AddressTypes { HOME, OnlinePayment }

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  var myType = AddressTypes.HOME;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double discount = 10;
    double discountValue = 0.0;
    double shippingCharge = 3.7;
    double? total = 0.0;

    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: Text("\$${totalPrice < 300 ? totalPrice : total + 5}",
            style: TextStyle(
                color: Colors.green[900],
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.OnlinePayment
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyGooglePay(
                            total: total,
                          )))
                  : Container();
            },
            color: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text("Please Order", style: TextStyle(color: textColor)),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SingleDeliveryItemWidget(
                address:
                    "area, ${widget.deliverAddressList.area} , street, ${widget.deliverAddressList.street} , society, ${widget.deliverAddressList.society} , PinCode, ${widget.deliverAddressList.pinCode}",
                addressType:
                    widget.deliverAddressList.addressType == "AddressTypes.Home"
                        ? "Home"
                        : widget.deliverAddressList.addressType ==
                                "AddressTypes.Work"
                            ? "Work"
                            : "Other",
                number: widget.deliverAddressList.mobileNo,
                title:
                    "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
              ),
              const Divider(color: Colors.black),
              ExpansionTile(
                title: Text(
                    "Order Items ${reviewCartProvider.getreviewCartDataList.length}"),
                children: reviewCartProvider.getreviewCartDataList.map((e) {
                  return OrderItemWidget(reviewCartModel: e);
                }).toList(),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  "Sub Total",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Text(
                  "\$${totalPrice + 5}",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                title: const Text(
                  "Shipping Charge",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  " \$$discountValue",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const ListTile(
                title: Text(
                  "Compen Discount",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  "10 \$",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const Divider(),
              const ListTile(
                title: Text("Payment Options"),
              ),
              RadioListTile(
                value: AddressTypes.HOME,
                groupValue: myType,
                title: const Text("Home"),
                secondary: Icon(Icons.home, color: primaryColor),
                onChanged: (value) {
                  setState(() {
                    myType = value!;
                  });
                },
              ),
              RadioListTile(
                value: AddressTypes.OnlinePayment,
                groupValue: myType,
                title: const Text("Online Payment"),
                secondary: Icon(Icons.payments, color: primaryColor),
                onChanged: (value) {
                  setState(() {
                    myType = value!;
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
