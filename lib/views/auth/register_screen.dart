import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_const.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/app_dropdown.dart';
import 'package:jiffy_fuels_consumer/widgets/dialogs.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:place_picker/place_picker.dart';
import '../../const/app_colors.dart';
import '../../const/screen_size.dart';
import '../../controllers/phone_auth_controller.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        backgroundColor: AppColor.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: GetBuilder(
              init: PhoneAuthController(),
              builder: (_) => Form(
                key: phoneAuthController.registerKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back,
                          size: ScreenSize.width(context) * 0.075,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.width(context) * 0.025,
                    ),

                    CircleAvatar(
                      backgroundColor: AppColor.white,
                      radius: ScreenSize.width(context) * 0.2,
                      child: Center(
                        child: Image.asset(
                          AppImages.appLogo,
                          height: ScreenSize.height(context) * 0.2,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.width(context) * 0.04,
                    ),

                    ///NAME
                    TitleTextField(
                      title: 'Name',
                      hint: 'Name',
                      icon: const Icon(Icons.person),
                      controller: phoneAuthController.name,
                      onSubmit: (val) =>
                          phoneAuthController.nameNode.requestFocus(),
                      validator: (val) =>
                      val!.isEmpty ? 'Enter your name' : null,
                    ),

                    ///EMAIL
                    TitleTextField(
                      title: 'Email',
                      hint: 'Email',
                      icon: const Icon(Icons.email),
                      controller: phoneAuthController.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val!.isEmail
                          ? null
                          : 'Enter valid email address',
                      onSubmit: (val) =>
                          phoneAuthController.emailNode.requestFocus(),
                    ),

                    ///PHONE NUMBER - ALREADY ENTERED
                    TitleTextField(
                      title: 'Phone',
                      hint: 'Phone',
                      enabled: false,
                      icon: const Icon(Icons.phone),
                      controller: phoneAuthController.mobile,
                      keyboardType: TextInputType.phone,
                      validator: (val) => val!.length == 10
                          ? null
                          : 'Enter valid Phone Number',
                      onSubmit: (val) =>
                          phoneAuthController.mobileNode.requestFocus(),
                    ),

                    ///PASSWORD
                    Obx(
                          () => TitleTextField(
                        title: 'Password',
                        hint: 'Password',
                        controller: phoneAuthController.password,
                        icon: const Icon(Icons.key),
                        obscure: phoneAuthController
                            .registerPasswordObscure.value,
                        iconData: phoneAuthController
                            .registerPasswordObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () => phoneAuthController
                            .registerPasswordObscure.value =
                        !phoneAuthController
                            .registerPasswordObscure.value,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minimum 6 characters',
                      ),
                    ),

                    ///CONFIRM PASSWORD
                    Obx(
                          () => TitleTextField(
                        title: 'Confirm Password',
                        hint: 'Confirm Password',
                        icon: const Icon(Icons.key),
                        controller: phoneAuthController.confirmPassword,
                        obscure: phoneAuthController
                            .registerConfirmObscure.value,
                        iconData: phoneAuthController
                            .registerConfirmObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () => phoneAuthController
                            .registerConfirmObscure.value =
                        !phoneAuthController
                            .registerConfirmObscure.value,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minimum 6 characters',
                      ),
                    ),

                    const SizedBox(height: 10),

                    ///REGISTER BUTTON
                    JiffyButton(
                      buttonText: 'REGISTER',
                      onTap: phoneAuthController.submitRegister,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


///OLD EMAIL WITH VALIDATION
// TitleTextField(
//   title: 'Email Address',
//   controller: authController.email,
//   keyboardType: TextInputType.emailAddress,
//   validator: (val) => val!.isEmail
//       ? null
//       : 'Enter valid email address',
//   onChanged: (val) =>
//       authController.isEmailAvailable(val: val),
// ),
// if (authController.email.text.isEmail)
//   Obx(
//     () => Text(
//       authController.emailAvailable.value
//           ? 'Email Available'
//           : 'Email already exists',
//       textAlign: TextAlign.end,
//       style: TextStyle(
//         color: authController.emailAvailable.value
//             ? Colors.green
//             : Colors.red,
//       ),
//     ),
//   ),