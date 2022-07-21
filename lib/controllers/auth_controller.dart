import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy_fuels_consumer/const/phone_auth_user_data.dart';
import 'package:jiffy_fuels_consumer/controllers/user_controller_old.dart';
import 'package:jiffy_fuels_consumer/models/shop_time.dart';
import 'package:jiffy_fuels_consumer/services/auth_service.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/select_time_screen.dart';
import '../views/home_main/home_screen_main.dart';

final AuthController authController = Get.find<AuthController>();

class AuthController extends GetxController {
  RxBool isSelected = false.obs,
      everyday = true.obs,
      phoneAvailable = true.obs,
      loginObscure = false.obs,
      registerPasswordObscure = false.obs,
      registerConfirmObscure = false.obs;

  final GlobalKey<FormState> register = GlobalKey<FormState>(),
      login = GlobalKey<FormState>(),
      signup = GlobalKey<FormState>(),
      otp = GlobalKey<FormState>();

  List<RxBool> selectedDays = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
  ];

  List<ShopTimings> selectedTimes = [];
  double lat = 0.00, lon = 0.00;

  RxString status = ''.obs;
  List availaleOils = [], selectedOils = [];
  File? image, shopBanner;
  String openTime = '00:00', closeTime = '00:00';

  FocusNode emailNode = FocusNode(),
      phoneNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode(),
      minAmountNode = FocusNode(),
      offerPercentNode = FocusNode(),
      maxDelNode = FocusNode(),
      descriptionNode = FocusNode(),
      landmarkNode = FocusNode();

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
      landmark = TextEditingController();

  PhoneAuthService phoneAuthService = PhoneAuthService();
  UserData userData = UserData();
  //UserData userData = UserData();

  //CHECKING IF USER IS LOGGED IN OR NOT
  checkAuth() {
    Future.delayed(2.seconds, () async {
      String user = await userData.getUserPhone();
      if (user.isEmpty) {
        Get.off(() => const LoginScreen());
      } else {
        ///userController.retailerProfile();
        Get.off(() => const HomeScreenMain());
      }
    });
  }

  submitRegister() async {
    if (!phoneAvailable.value) {
      Fluttertoast.showToast(msg: 'Email is already registered');
    } else if (image == null) {
      Fluttertoast.showToast(msg: 'Select Image');
    } else if (shopBanner == null) {
      Fluttertoast.showToast(msg: 'Select Banner Image');
    } else if (password.text != confirmPassword.text) {
      Fluttertoast.showToast(msg: 'Both passwords should match');
      return;
    } else if (register.currentState!.validate()) {
      showSpinner();
      try {
        bool res = await phoneAuthService.registerUser(
          name: name.text,
          email: email.text,
          phone: phone.text,
          password: password.text,
        );
        await userData.setUserEmail(email: email.text);
        if (res) Get.to(() => const SelectTimeScreen());
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }

  ///no use
  isEmailAvailable({String? val}) async {
    try {
      var res = await phoneAuthService.checkEmail(email: val!);
      phoneAvailable.value = res == 0;
    } catch (_) {
      phoneAvailable.value = false;
    }
  }

  loginRetailer() async {
    if (login.currentState!.validate()) {
      showSpinner();
      try {
        int res = await phoneAuthService.login(
            email: email.text, password: password.text);
        if (res == 1) {
          await userData.setUserEmail(email: email.text);
          Get.offAll(
            () => const HomeScreenMain(),
          );
        } else {
          Fluttertoast.showToast(msg: 'User not found');
        }
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }

  ///---------------------------------------

  oilCompanies() async {
    availaleOils = await phoneAuthService.getOilCompanies();
  }

  selectOilCompanies({index}) {
    var oil = availaleOils[index];
    selectedOils.contains(oil)
        ? selectedOils.remove(oil)
        : selectedOils.add(oil);
    oilCompany.text = selectedOils.join(',');
    update();
  }

  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }

  selectShopBanner() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      shopBanner = File(img.path);
      update();
    }
  }

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

  updateTime() async {
    if (everyday.value) {
      if (openTime == '00:00' || closeTime == '00:00') {
        Fluttertoast.showToast(msg: 'Select Open and Close time');
        return;
      }
    }
    showSpinner();
    try {
      await phoneAuthService.setTiming(
        email: email.text,
        everyDay: everyday.value,
        openTime: openTime,
        closeTime: closeTime,
        selectedTimes: selectedTimes,
      );
      Fluttertoast.showToast(msg: 'Timings Updated');
      Future.delayed(1.seconds, () {
        Get.offAll(() => const HomeScreenMain());
      });
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
    hideSpinner();
  }
}
