import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jiffy_fuels_consumer/const/phone_auth_user_data.dart';
import 'package:jiffy_fuels_consumer/services/product_service.dart';
import '../models/retailer.dart';



class UserService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  ProductService productService = ProductService();

  Future getProfile() async {
    var phone = await UserData().getUserPhone();
    var res = await firebaseFirestore.collection('users').doc(phone).get();
    // print(res.data());
    return profileFromJson(res.data());
  }


  Future<bool> updateProfile({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String deviceId,
    required String createdAt,
    required bool status,
    required String profileImage,
    File? image
  }) async {
    String imageUrl = profileImage;
    if (image != null) {
      if (profileImage.isNotEmpty) {
        await firebaseStorage.refFromURL(profileImage).delete();
      }
      var imageTask = await firebaseStorage
          .ref('/user_images/${image.path.split('/').last}')
          .putFile(image);

      imageUrl = await imageTask.ref.getDownloadURL();
    }

    await firebaseFirestore.collection('users').doc(email).update({
      "name": name,
      "phone": phone,
      "email": email,
      "profile_image": imageUrl,
      "password": password,
      "device_id": deviceId,
      "created_at": DateTime.now(),
      "status": status,
    });
    return true;
  }



  Future<int> login({
    required String phone,
    required String password,
  }) async {
    var res = await firebaseFirestore
        .collection('users')
        .where("phone", isEqualTo: phone)
        .where("password", isEqualTo: password)
        .get();
    // print(res);
    return res.docs.length;
  }

  ///PHONE AUTH - UPDATE PASSWORD
  Future changePassword({required String password}) async {
    var phone = await UserData().getUserPhone();
    await firebaseFirestore
        .collection('users')
        .doc(phone)
        .update({'password': password});
  }
}
