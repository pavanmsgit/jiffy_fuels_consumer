import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/views/home_main/home_sub_pages/account_screen.dart';
import 'package:jiffy_fuels_consumer/views/home_main/home_sub_pages/home_screen.dart';
import 'package:jiffy_fuels_consumer/views/home_main/home_sub_pages/revenue_screen.dart';

final HomeController homeController = Get.find<HomeController>();

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxInt selectedTab = 0.obs;

  List screens = [
    const HomeScreen(),
    RevenueScreen(),
    RevenueScreen(),
    const AccountScreen(),
  ];

  Future<List> getPosterList() async {
    var res =
        await firebaseFirestore.collection('posters').doc('posters').get();
    return res['poster_list'];
  }

  Future<Stream<QuerySnapshot<Object?>>> getRetailerList() async {
    var res = await firebaseFirestore
        .collection('retailers')
        //.orderBy('priority')
        .snapshots();
    return res;
  }
}
