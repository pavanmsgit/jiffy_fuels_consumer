import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jiffy_fuels_consumer/models/shop_time.dart';

class PhoneAuthService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;



  ///PHONE AUTH - CHECK PHONE NUMBER
  Future<int> checkPhone({required String phone}) async {
    var res = await firebaseFirestore
        .collection('users')
        .where("phone", isEqualTo: phone)
        .get();
    // print(res.docs);
    return res.docs.length;
  }


  ///PHONE AUTH - REGISTER USER
  Future<bool> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await firebaseFirestore.collection('users').doc(phone).set({
      'name': name,
      'email': email,
      'phone': phone,
      'password':password,
      'created_at': DateTime.now(),
    });
    return true;
  }

  ///phone auth - check if user exists
  Future<int> checkUserLoggedInDatabase({
    required String phone,
  }) async {
    var res = await firebaseFirestore
        .collection('users')
        .where("phone", isEqualTo: phone)
        .get();
    // print(res);
    return res.docs.length;
  }



  ///phone auth - CHECK IF THE USER IS ALREADY REGISTERED AND LOGIN
  Future<int> checkIfUserIsRegistered({
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





  ///-------------------------------------------------------------------

  ///NO USE
  Future<int> checkEmail({required String email}) async {
    var res = await firebaseFirestore
        .collection('retailers')
        .where("email", isEqualTo: email)
        .get();
    // print(res.docs);
    return res.docs.length;
  }


  ///no use
  Future setTiming({
    required bool everyDay,
    required String email,
    required String openTime,
    required String closeTime,
    required List<ShopTimings> selectedTimes,
  }) async {
    await firebaseFirestore.collection('retailers').doc(email).update({
      'every_day': everyDay,
      'open_time': openTime,
      'close_time': closeTime,
      'selected_times': shopTimingsToJson(selectedTimes),
    });
    return true;
  }

  ///no use
  Future<int> login({
    required String email,
    required String password,
  }) async {
    var res = await firebaseFirestore
        .collection('retailers')
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    // print(res);
    return res.docs.length;
  }


  ///NO USE
  Future<List> getOilCompanies() async {
    var res =
    await firebaseFirestore.collection('oil_marketing').doc('oils').get();
    // print(res['companies']);
    return res['companies'];
  }

  ///NO USE
  Future<bool> registerUserEmail({
    required String name,
    required String email,
    required List oilMarketings,
    required String phone,
    required String password,
    required String status,
    required String minAmount,
    required String maxDelTime,
    required String offerPercent,
    required String description,
    required String address,
    required String landmark,
    required double lat,
    required double lon,
    required File image,
    required File shopBanner,
  }) async {
    var imageTask = await firebaseStorage
        .ref('/retailer_images/${image.path.split('/').last}')
        .putFile(image);
    String imageUrl = await imageTask.ref.getDownloadURL();

    var bannerTask = await firebaseStorage
        .ref('/retailer_images/${shopBanner.path.split('/').last}')
        .putFile(shopBanner);
    String bannerUrl = await bannerTask.ref.getDownloadURL();

    await firebaseFirestore.collection('retailers').doc(email).set({
      'name': name,
      'email': email,
      'phone': phone,
      'oil_marketing': oilMarketings,
      'password': password,
      'min_amount': minAmount,
      'max_del_time': maxDelTime,
      'offer_percent': offerPercent,
      'status': status,
      'address': address,
      'lat': lat,
      'lon': lon,
      'description': description,
      'landmark': landmark,
      'image': imageUrl,
      'banner_image': bannerUrl,
      'created_at': DateTime.now(),
    });
    return true;
  }





}




class AuthService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<int> checkEmail({required String email}) async {
    var res = await firebaseFirestore
        .collection('retailers')
        .where("email", isEqualTo: email)
        .get();
    // print(res.docs);
    return res.docs.length;
  }

  Future<List> getOilCompanies() async {
    var res =
    await firebaseFirestore.collection('oil_marketing').doc('oils').get();
    // print(res['companies']);
    return res['companies'];
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required List oilMarketings,
    required String phone,
    required String password,
    required String status,
    required String minAmount,
    required String maxDelTime,
    required String offerPercent,
    required String description,
    required String address,
    required String landmark,
    required double lat,
    required double lon,
    required File image,
    required File shopBanner,
  }) async {
    var imageTask = await firebaseStorage
        .ref('/retailer_images/${image.path.split('/').last}')
        .putFile(image);
    String imageUrl = await imageTask.ref.getDownloadURL();

    var bannerTask = await firebaseStorage
        .ref('/retailer_images/${shopBanner.path.split('/').last}')
        .putFile(shopBanner);
    String bannerUrl = await bannerTask.ref.getDownloadURL();

    await firebaseFirestore.collection('retailers').doc(email).set({
      'name': name,
      'email': email,
      'phone': phone,
      'oil_marketing': oilMarketings,
      'password': password,
      'min_amount': minAmount,
      'max_del_time': maxDelTime,
      'offer_percent': offerPercent,
      'status': status,
      'address': address,
      'lat': lat,
      'lon': lon,
      'description': description,
      'landmark': landmark,
      'image': imageUrl,
      'banner_image': bannerUrl,
      'created_at': DateTime.now(),
    });
    return true;
  }

  Future setTiming({
    required bool everyDay,
    required String email,
    required String openTime,
    required String closeTime,
    required List<ShopTimings> selectedTimes,
  }) async {
    await firebaseFirestore.collection('retailers').doc(email).update({
      'every_day': everyDay,
      'open_time': openTime,
      'close_time': closeTime,
      'selected_times': shopTimingsToJson(selectedTimes),
    });
    return true;
  }

  Future<int> login({
    required String email,
    required String password,
  }) async {
    var res = await firebaseFirestore
        .collection('retailers')
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    // print(res);
    return res.docs.length;
  }
}
