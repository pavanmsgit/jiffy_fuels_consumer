// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:jiffy_fuels_consumer/const/phone_auth_user_data.dart';
import 'package:jiffy_fuels_consumer/services/auth_service.dart';
import 'package:jiffy_fuels_consumer/views/auth/otpScreen.dart';
import 'package:jiffy_fuels_consumer/views/auth/register_screen.dart';
import 'package:jiffy_fuels_consumer/views/home_main/home_screen_main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/auth/login_screen.dart';
import '../widgets/loading_widget.dart';

final PhoneAuthController phoneAuthController = Get.find<PhoneAuthController>();

class PhoneAuthController extends GetxController {
  RxBool phoneAvailable = true.obs,
      loginObscure = false.obs,
      registerPasswordObscure = false.obs,
      registerConfirmObscure = false.obs;

  String verificationId = '';

  FocusNode mobileNode = FocusNode(),
      mobileSignUpNode = FocusNode(),
      otpNode = FocusNode(),
      nameNode = FocusNode(),
      emailNode = FocusNode(),
      passwordNode = FocusNode(),
      confirmPasswordNode = FocusNode();

  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      mobile = TextEditingController(),
      mobileSignUp = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      otp = TextEditingController();

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>(),
      loginKey = GlobalKey<FormState>(),
      signUpKey = GlobalKey<FormState>(),
      otpPageKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  PhoneAuthService authService = PhoneAuthService();
  UserData userData = UserData();

  getLocationPermission() async {
    await Permission.location.request();
  }

  isPhoneAvailable({String? val}) async {
    try {
      var res = await authService.checkPhone(phone: val!);
      phoneAvailable.value = res == 0;
    } catch (_) {
      phoneAvailable.value = false;
    }
  }

  //CHECKING IF USER IS LOGGED IN OR NOT
  checkAuth() {
    Future.delayed(2.seconds, () async {
      String user = await userData.getUserPhone();
      if (user.isEmpty) {
        Get.off(() => const LoginScreen());
      } else {
        //TODO
        //userController.retailerProfile();
        Get.off(() => const HomeScreenMain());
      }
    });
  }

  sendOtpToDevice() async {
    if (signUpKey.currentState!.validate()) {
      if (mobileSignUp.text.isEmpty) {
        Get.snackbar(
          'Enter Valid Number',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        mobileSignUpNode.unfocus();
        sendOtp();
      }
    }
  }

  sendOtp() async {
    showSpinner(message: 'Sending Otp...');
    //String countryCode = phone.text.length == 10 ? '+91' : '+974';
    String countryCode = '+91';
    print("phone.text  ${mobileSignUp.text}");
    auth.verifyPhoneNumber(
        phoneNumber: "$countryCode${mobileSignUp.text}",
        //phoneNumber: "+918296731873",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          otpNode.unfocus();
          showSpinner(message: 'Verifying...');
          auth.signInWithCredential(authCredential).then((result) async {
            var res = await authService.checkUserLoggedInDatabase(
                phone: mobileSignUp.text);
            hideSpinner();
            if (res == 0) {
              await userData.setUserPhone(phone: mobileSignUp.text);
              Get.to(() => const RegisterScreen());
            } else {
              Get.snackbar(
                'Already Exists',
                '',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
              );
            }
          }).catchError((_) {
            hideSpinner();
          });
        },
        verificationFailed: (authException) {
          // print(authException);
          hideSpinner();
          Get.snackbar(
            authException.toString(),
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
          );
        },
        codeSent: (verId, i) async {
          verificationId = verId;
          hideSpinner();
          showSpinner(message: 'Otp Sent');
          otp = TextEditingController(text: '');
          Future.delayed(Duration(seconds: 1), () {
            hideSpinner();
            Get.to(() => OtpScreen());
          });
          update();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          // print(verificationId);
        });
  }

  verifyOtpAtOtpPage(context) async {
    if (otpPageKey.currentState!.validate()) {
      if (otp.text.length != 6) {
        Get.snackbar(
          'Enter Valid 6 digit OTP',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        try {
          otpNode.unfocus();
          var credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otp.text,
          );
          showSpinner(message: 'Verifying the number');
          auth.signInWithCredential(credential).then((result) async {
            verifyOtp(context);
          }).catchError((e) {
            hideSpinner();
            Get.snackbar(
              e.toString(),
              '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            );
          });
        } catch (e) {
          // print(e);
          hideSpinner();
        }
      }
    }
  }

  Future verifyOtp(context) async {
    try {
      showSpinner();
      //var user = await authService.loginUser(mobile: mobile.text);
      var user =
          await authService.checkUserLoggedInDatabase(phone: mobileSignUp.text);
      hideSpinner();
      if (user == 1) {
        Fluttertoast.showToast(msg: 'Account Already Exists');
      } else if (user == 0) {
        Fluttertoast.showToast(msg: 'Verified');
        otp = TextEditingController(text: '');
        update();
        await userData.setUserPhone(phone: mobile.text);
        Get.to(() => const RegisterScreen());
      } else {
        Get.snackbar(
          'Please re try after sometime',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      hideSpinner();
    }
  }

  ///LOGIN USER - IF ALREADY REGISTERED
  ///TODO - CHECK PASSWORD WRONG AND SHOW TOAST
  loginUser() async {
    if (loginKey.currentState!.validate()) {
      showSpinner();
      try {
        int res = await authService.checkIfUserIsRegistered(
            phone: mobile.text, password: password.text);
        if (res == 1) {
          await userData.setUserPhone(phone: mobile.text);
          Get.offAll(
            () => const HomeScreenMain(),
          );
        } else {
          Fluttertoast.showToast(msg: 'Please try again');
        }
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }

  submitRegister() async {
    if (!phoneAvailable.value) {
      Fluttertoast.showToast(msg: 'Phone is already registered');
    } else if (name.text == '') {
      Fluttertoast.showToast(msg: 'Please enter Name');
    } else if (email.text == '') {
      Fluttertoast.showToast(msg: 'Please enter Email');
    } else if (password.text != confirmPassword.text) {
      Fluttertoast.showToast(msg: 'Both passwords should match');
      return;
    } else if (registerKey.currentState!.validate()) {
      showSpinner();
      try {
        bool res = await authService.registerUser(
          name: name.text,
          email: email.text,
          phone: mobile.text,
          password: password.text,
        );
        await userData.setUserPhone(phone: mobile.text);
        if (res) Get.to(() => const HomeScreenMain());
      } catch (err) {
        Fluttertoast.showToast(msg: err.toString());
      }
      hideSpinner();
    }
  }
}
