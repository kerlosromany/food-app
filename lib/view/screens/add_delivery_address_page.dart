import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/view/widgets/costum_text_field.dart';
import 'package:provider/provider.dart';

import 'costom_google_map_page.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({super.key});

  @override
  State<AddDeliveryAddressScreen> createState() =>
      _AddDeliveryAddressScreenState();
}

enum AddressTypes { HOME, WORK, OTHER }

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  var myType = AddressTypes.HOME;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    // TextEditingController firstNameController = TextEditingController();
    // TextEditingController lastNameController = TextEditingController();
    // TextEditingController mobileNoController = TextEditingController();
    // TextEditingController mobileNoAlterController = TextEditingController();
    // TextEditingController societyController = TextEditingController();
    // TextEditingController streetController = TextEditingController();
    // TextEditingController landmarkController = TextEditingController();
    // TextEditingController cityController = TextEditingController();
    // TextEditingController areaController = TextEditingController();
    // TextEditingController pinCodeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Delivery Address"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: checkOutProvider.isLoading == false
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  checkOutProvider.validator(context, myType);
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Add Address"),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            CostumTextField(
              labText: "First Name",
              controller: checkOutProvider.firstNameController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Last Name",
              controller: checkOutProvider.lastNameController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Mobile No",
              controller: checkOutProvider.mobileNoController,
              textInputType: TextInputType.phone,
            ),
            CostumTextField(
              labText: "Mobile No Alternative",
              controller: checkOutProvider.mobileNoAlterController,
              textInputType: TextInputType.phone,
            ),
            CostumTextField(
              labText: "Society",
              controller: checkOutProvider.societyController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Street",
              controller: checkOutProvider.streetController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Landmark",
              controller: checkOutProvider.landmarkController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "City",
              controller: checkOutProvider.cityController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Area",
              controller: checkOutProvider.areaController,
              textInputType: TextInputType.text,
            ),
            CostumTextField(
              labText: "Pin code",
              controller: checkOutProvider.pinCodeController,
              textInputType: TextInputType.number,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CostomGoogleMap()));
              },
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: unnecessary_null_comparison
                    checkOutProvider.setLocation == null
                        ? const Text("Set Location")
                        : const Text("Done"),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.black),
            const ListTile(
              title: Text("Address Type"),
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
              value: AddressTypes.WORK,
              groupValue: myType,
              title: const Text("Work"),
              secondary: Icon(Icons.work, color: primaryColor),
              onChanged: (value) {
                setState(() {
                  myType = value!;
                });
              },
            ),
            RadioListTile(
              value: AddressTypes.OTHER,
              groupValue: myType,
              title: const Text("Others"),
              secondary: Icon(Icons.devices_other, color: primaryColor),
              //onChanged: (v) {},
              onChanged: (value) {
                setState(() {
                  myType = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
