import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy_fuels_consumer/models/products.dart';
import 'package:jiffy_fuels_consumer/models/retailer.dart';
import 'package:jiffy_fuels_consumer/models/shop_time.dart';
import 'package:jiffy_fuels_consumer/services/product_service.dart';
import 'package:jiffy_fuels_consumer/services/retailer_service.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import '../views/home_main/home_screen_main.dart';
import '../views/home_main/home_sub_pages/home_screen.dart';


final RetailerController retailerController = Get.find<RetailerController>();

class RetailerController extends GetxController {

  RxBool isSelected = false.obs,
      everyday = true.obs,
      passwordObscure = true.obs,
      confirmPasswordObscure = true.obs,
      currentPasswordObscure = true.obs;

  double lat = 0.00, lon = 0.00;
  File? image, shopBanner;
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>(),
      changePasswordFormKey = GlobalKey<FormState>();
  RxString status = ''.obs;
  String openTime = '00:00', closeTime = '00:00';
  List<ShopTimings> selectedTimes = [];
  List<RxBool> selectedDays = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      oilCompany = TextEditingController(),
      confirmPassword = TextEditingController(),
      minAmount = TextEditingController(),
      offerPercentage = TextEditingController(),
      maxDelTime = TextEditingController(),
      description = TextEditingController(),
      address = TextEditingController(),
      landmark = TextEditingController(),
      currentPassword = TextEditingController(),
      newPassword = TextEditingController(),
      confirmNewPassword = TextEditingController();
  String imageUrl = '', bannerUrl = '';

  List<Retailer> retailer = [];

  RetailerService retailerService = RetailerService();

  getRetailers() async {
    retailer = await retailerService.allRetailers();
    update();
  }

  assignRetailerData({required Retailer retailer}) {
    name.text = retailer.name;
    email.text = retailer.email;
    oilCompany.text = retailer!.oilMarketing.join(',');
    phone.text = retailer!.phone;
    password.text = retailer!.password;
    confirmPassword.text = retailer!.password;
    status.value = retailer!.status;
    description.text = retailer!.description;
    minAmount.text = retailer!.minAmount;
    offerPercentage.text = retailer!.offerPercent;
    maxDelTime.text = retailer!.maxDelTime;
    address.text = retailer!.address;
    landmark.text = retailer!.landmark;
    imageUrl = retailer!.image;
    bannerUrl = retailer!.bannerImage;
    everyday.value = retailer!.everyDay;
    openTime = retailer!.openTime;
    closeTime = retailer!.closeTime;
    selectedTimes = retailer!.timings;
    for (var timing in selectedTimes) {
      if (timing.openTime != '00:00' && timing.closeTime != '00:00') {
        selectedDays[selectedTimes.indexOf(timing)].value = true;
      }
    }
    update();
  }
}
