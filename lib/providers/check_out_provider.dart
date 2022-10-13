import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController mobileNoAlterController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  LocationData? setLocation;

  void validator(context, myType) async {
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("First Name is Empty")));
    } else if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Last Name is Empty")));
    } else if (mobileNoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mobile number is Empty")));
    } else if (mobileNoAlterController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mobile number alternative is Empty")));
    } else if (societyController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Society is Empty")));
    } else if (streetController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Street is Empty")));
    } else if (landmarkController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("LandMark is Empty")));
    } else if (cityController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("City is Empty")));
    } else if (areaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Area is Empty")));
    } else if (pinCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Pincode is Empty")));
    }
    // ignore: unnecessary_null_comparison
    else if (setLocation == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Set Loation is Empty")));
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobileNo": mobileNoController.text,
        "mobileNoAlter": mobileNoAlterController.text,
        "society": societyController.text,
        "street": streetController.text,
        "landmaark": landmarkController.text,
        "city": cityController.text,
        "area": areaController.text,
        "pincode": pinCodeController.text,
        "latitude": setLocation?.latitude,
        "longitude": setLocation?.longitude,
        "addressType": myType.toString(),
      }).then((value) => {
                isLoading = false,
                notifyListeners(),
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Add your deliver address"))),
                Navigator.of(context).pop(),
                notifyListeners(),
              });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];
  getDeliveryAddress() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        mobileNo: _db.get("mobileNo"),
        mobileNoAlter: _db.get("mobileNoAlter"),
        society: _db.get("society"),
        street: _db.get("street"),
        landmark: _db.get("landmaark"),
        city: _db.get("city"),
        area: _db.get("area"),
        pinCode: _db.get("pincode"),
        addressType: _db.get("addressType"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }
    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }

  
}
