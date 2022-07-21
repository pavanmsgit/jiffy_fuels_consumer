import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/home_controller.dart';
import 'package:jiffy_fuels_consumer/models/retailer.dart';
import 'package:jiffy_fuels_consumer/models/users.dart';
import 'package:jiffy_fuels_consumer/services/auth_service.dart';
import 'package:jiffy_fuels_consumer/services/user_service.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../models/shop_time.dart';

final UserController userController = Get.find<UserController>();

class UserController extends GetxController {
  RxBool isSelected = false.obs,
      passwordObscure = true.obs,
      confirmPasswordObscure = true.obs,
      currentPasswordObscure = true.obs;

  double lat = 0.00, lon = 0.00;
  File? image;

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>(),
      changePasswordFormKey = GlobalKey<FormState>();


  bool? status;

  User? profile;

  TextEditingController
      name = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      currentPassword = TextEditingController(),
      newPassword = TextEditingController(),
      confirmNewPassword = TextEditingController();

  String imageUrl = '';
  UserService userService = UserService();
  PhoneAuthService authService = PhoneAuthService();

  userProfile() async {
    profile = await userService.getProfile();
    name.text = profile!.name;
    email.text = profile!.email;
    phone.text = profile!.phone;
    password.text = profile!.password;
    confirmPassword.text = profile!.password;
    status = profile!.status;
    imageUrl = profile!.profileImage;
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


  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }


  updateProfile() async {
    if (profileFormKey.currentState!.validate()) {
      if (imageUrl.isEmpty && image == null) {
        Fluttertoast.showToast(msg: 'Select Image');
      } else if (password.text != confirmPassword.text) {
        Fluttertoast.showToast(msg: 'Both passwords should match');
        return;
      }
      showSpinner();
      try {
        bool res = await userService.updateProfile(
          name: name.text,
          email: email.text,
          phone: phone.text,
          password: password.text,
          //status: status.obs.,
          image: image,
          profileImage: imageUrl,
          status: true,
          deviceId: '',
          createdAt: DateTime.now().toString(),
        );
        if (res) {
          image = null;
          userProfile();
          Fluttertoast.showToast(msg: 'Profile Updated');
        }
      } catch (err) {
        print(err);
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }
}
