import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jiffy_fuels_consumer/const/phone_auth_user_data.dart';

import '../models/products.dart';

class ProductService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future allProducts(email) async {
    var res = await firebaseFirestore
        .collection('products')
        .where('retailer_email', isEqualTo: email)
        .get();

    return productsFromJson(res.docs);
  }
}
