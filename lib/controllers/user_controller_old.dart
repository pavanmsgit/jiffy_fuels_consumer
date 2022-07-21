import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/home_controller.dart';
import 'package:jiffy_fuels_consumer/models/retailer.dart';
import 'package:jiffy_fuels_consumer/services/auth_service.dart';
import 'package:jiffy_fuels_consumer/services/user_service.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../models/shop_time.dart';

final UserControllerOld userController = Get.find<UserControllerOld>();

class UserControllerOld extends GetxController {
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
  Retailer? profile;
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
  UserService userService = UserService();
  AuthService authService = AuthService();

  retaileProfile() async {
    //profile = await homeController.getRetailerList();
    name.text = profile!.name;
    email.text = profile!.email;
    oilCompany.text = profile!.oilMarketing.join(',');
    phone.text = profile!.phone;
    password.text = profile!.password;
    confirmPassword.text = profile!.password;
    status.value = profile!.status;
    description.text = profile!.description;
    minAmount.text = profile!.minAmount;
    offerPercentage.text = profile!.offerPercent;
    maxDelTime.text = profile!.maxDelTime;
    address.text = profile!.address;
    landmark.text = profile!.landmark;
    imageUrl = profile!.image;
    bannerUrl = profile!.bannerImage;
    everyday.value = profile!.everyDay;
    openTime = profile!.openTime;
    closeTime = profile!.closeTime;
    selectedTimes = profile!.timings;
    for (var timing in selectedTimes) {
      if (timing.openTime != '00:00' && timing.closeTime != '00:00') {
        selectedDays[selectedTimes.indexOf(timing)].value = true;
      }
    }
    update();
  }


  changePassword() async {
    if (changePasswordFormKey.currentState!.validate()) {
      if (currentPassword.text != profile!.password) {
        Fluttertoast.showToast(msg: 'Current password is not correct');
        return;
      } else if (newPassword.text != confirmNewPassword.text) {
        Fluttertoast.showToast(
          msg: 'Both passwords should be same',
        );
        return;
      } else if (currentPassword.text == newPassword.text) {
        Fluttertoast.showToast(
          msg: 'Old and new passwords cannot be same',
        );
        return;
      }
      showSpinner();
      try {
        await userService.changePassword(password: newPassword.text);
        currentPassword.clear();
        newPassword.clear();
        confirmNewPassword.clear();
        update();
        Fluttertoast.showToast(msg: 'Password changed');
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }


  ///----------------------------------------------
  ///NO USE
  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }

  ///NO USE
  selectShopBanner() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      shopBanner = File(img.path);
      update();
    }
  }

  ///NO USE
  selectOpenTime(context, {index}) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        if (index == -1) {
          openTime = time.format(context);
        } else {
          selectedTimes[index].openTime = time.format(context);
        }
        update();
      }
    });
  }

  ///NO USE
  selectCloseTime(context, {index}) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        if (index == -1) {
          closeTime = time.format(context);
        } else {
          selectedTimes[index].closeTime = time.format(context);
        }
        update();
      }
    });
  }

  ///NO USE
  updateProfile() async {
    // if (profileFormKey.currentState!.validate()) {
    //   if (imageUrl.isEmpty && image == null) {
    //     Fluttertoast.showToast(msg: 'Select Image');
    //   } else if (bannerUrl.isEmpty && shopBanner == null) {
    //     Fluttertoast.showToast(msg: 'Select Banner Image');
    //   } else if (password.text != confirmPassword.text) {
    //     Fluttertoast.showToast(msg: 'Both passwords should match');
    //     return;
    //   }
    //   showSpinner();
    //   try {
    //     bool res = await userService.updateProfile(
    //       name: name.text,
    //       email: email.text,
    //       oilMarketings: authController.selectedOils,
    //       phone: phone.text,
    //       password: password.text,
    //       status: status.value,
    //       minAmount: minAmount.text,
    //       maxDelTime: maxDelTime.text,
    //       offerPercent: offerPercentage.text,
    //       description: description.text,
    //       address: address.text,
    //       landmark: landmark.text,
    //       lat: lat,
    //       lon: lon,
    //       image: image,
    //       shopBanner: shopBanner,
    //       shopimageUrl: imageUrl,
    //       shopbannerUrl: bannerUrl,
    //     );
    //     if (res) {
    //       image = null;
    //       shopBanner = null;
    //       ///retailerProfile();
    //       Fluttertoast.showToast(msg: 'Profile Updated');
    //     }
    //   } catch (err) {
    //     print(err);
    //     Fluttertoast.showToast(msg: err.toString());
    //   }
    //   hideSpinner();
    // }
  }

  ///NO USE
  updateTime() async {
    if (everyday.value) {
      if (openTime == '00:00' || closeTime == '00:00') {
        Fluttertoast.showToast(msg: 'Select Open and Close time');
        return;
      }
    }
    showSpinner();
    try {
      await authService.setTiming(
        email: email.text,
        everyDay: everyday.value,
        openTime: openTime,
        closeTime: closeTime,
        selectedTimes: selectedTimes,
      );
      Fluttertoast.showToast(msg: 'Timings Updated');
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }



}
