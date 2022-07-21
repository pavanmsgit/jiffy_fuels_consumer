///NEW FILE
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jiffy_fuels_consumer/const/phone_auth_user_data.dart';
import '../models/retailer.dart';

class RetailerService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future allRetailers() async {
    var phone = await UserData().getUserPhone();
    var res = await firebaseFirestore
        .collection('retailers')
        .orderBy('priority')
        .get();
    print('THIS IS FIREBASE QUERY FOR RETAILER CHECK ${res.docs.length}');
    return retailersFromJson(res.docs);
  }
}
