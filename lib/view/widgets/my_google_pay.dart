import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final total;
  const MyGooglePay({super.key, required this.total});

  @override
  State<MyGooglePay> createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  // var _paymentItems = [
  //   PaymentItem(
  //     label: 'Total',
  //     amount: "${widget.total}",
  //     status: PaymentItemStatus.final_price,
  //   )
  // ];

// In your Widget build() method
// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GooglePayButton(
            paymentConfigurationAsset: 'sample_payment_configuration.json',
            paymentItems: [
              PaymentItem(
              label: 'Total',
              amount: "${widget.total}",
              status: PaymentItemStatus.final_price,
            )
            ],
            //style: GooglePayButtonStyle.black,
            type: GooglePayButtonType.pay,
            onPaymentResult: onGooglePayResult,
          ),
        ],
      ),
    );
  }
}
