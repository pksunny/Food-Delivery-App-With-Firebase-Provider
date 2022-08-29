
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/delivery_model.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class DeliveryProvider with ChangeNotifier {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController alternateMobileNoController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  LocationData? setLocation;


  // ADD DELIVER ADDRESS IN DATABASE WITH VALIDATION
  void validator(myAddressType) async {

    if(firstNameController.text.isEmpty){
      Fluttertoast.showToast(msg: "First name is empty");
    } 
    else if(lastNameController.text.isEmpty){
      Fluttertoast.showToast(msg: "Last name is empty");
    } else if(mobileNoController.text.isEmpty){
      Fluttertoast.showToast(msg: "Mobile no is empty");
    } else if(alternateMobileNoController.text.isEmpty){
      Fluttertoast.showToast(msg: "Alternate mobile no is empty");
    } else if(societyController.text.isEmpty){
      Fluttertoast.showToast(msg: "Society is empty");
    } else if(streetController.text.isEmpty){
      Fluttertoast.showToast(msg: "Street is empty");
    } else if(landMarkController.text.isEmpty){
      Fluttertoast.showToast(msg: "Land mark is empty");
    } else if(cityController.text.isEmpty){
      Fluttertoast.showToast(msg: "City is empty");
    } else if(areaController.text.isEmpty){
      Fluttertoast.showToast(msg: "Area is empty");
    } else if(pinCodeController.text.isEmpty){
      Fluttertoast.showToast(msg: "Pin code is empty");
    } else if(setLocation!.longitude == null){
      Fluttertoast.showToast(msg: "Set Location is empty");
    }
    else {
      
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
        .collection('AddDeliveryAddress')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'mobileNo': mobileNoController.text,
          'alternateMobileNo': alternateMobileNoController.text,
          'society': societyController.text,
          'street': streetController.text,
          'landMark': landMarkController.text,
          'city': cityController.text,
          'area': areaController.text,
          'pinCode': pinCodeController.text,
          'addressType': myAddressType.toString(),
          'latitude': setLocation!.latitude,
          'longitude': setLocation!.longitude
        }).then((value) {
          
          CommonDialog.hideLoading();
          Fluttertoast.showToast(msg: "Your Delivery Address Added!");
          Get.back();
          
          notifyListeners();
        });
    }
  }

  // GET DELIVERY ADDRESS DATA
  List<DeliveryModel> deliveryModelList = [];

  void getDeliveryAddressData() async {

    DeliveryModel deliveryModel;

    List<DeliveryModel> newList = [];

    DocumentSnapshot db =  await FirebaseFirestore.instance
      .collection('AddDeliveryAddress')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

      if(db.exists){
        deliveryModel = DeliveryModel(
          firstName: db.get('firstName'), 
          lastName: db.get('lastName'), 
          mobileNo: db.get('mobileNo'), 
          alternateMobileNo: db.get('alternateMobileNo'), 
          society: db.get('society'), 
          street: db.get('street'), 
          landMark: db.get('landMark'), 
          city: db.get('city'), 
          area: db.get('area'), 
          pinCode: db.get('pinCode'), 
          addressType: db.get('addressType'),
        );
        newList.add(deliveryModel);
      }

      deliveryModelList = newList;
      notifyListeners();
  }

  List<DeliveryModel> get getDeliverAddressList {
    return deliveryModelList;
  }
}