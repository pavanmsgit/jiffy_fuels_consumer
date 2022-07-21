import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/phone_auth_controller.dart';
import 'package:jiffy_fuels_consumer/views/auth/register_screen.dart';
import 'package:jiffy_fuels_consumer/views/auth/sign_up_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/app_buttons.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import 'package:jiffy_fuels_consumer/widgets/text_field.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/screen_size.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: phoneAuthController.loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      backgroundColor: AppColor.white,
                      radius: ScreenSize.width(context) * 0.25,
                      child: Center(
                        child: Image.asset(
                          AppImages.appLogo,
                          height: ScreenSize.height(context) * 0.25,
                        ),
                      ),
                    ),


                    const SizedBox(height: 40),



                    //LOGIN PHONE NUMBER
                    TitleTextField(
                      title: 'Phone',
                      hint: 'Phone',
                      icon: const Icon(Icons.phone),
                      controller: phoneAuthController.mobile,
                      keyboardType: TextInputType.phone,
                      validator: (val) =>
                      val!.length == 10 ? null : 'Enter valid Phone Number',
                      onSubmit: (val) =>
                          phoneAuthController.mobileNode.requestFocus(),
                    ),


                    //PASSWORD
                    Obx(
                      () => TitleTextField(
                        title: 'Password',
                        hint: 'Password',
                        icon: const Icon(Icons.key),
                        controller: phoneAuthController.password,
                        obscure: phoneAuthController.loginObscure.value,
                        iconData: phoneAuthController.loginObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () => phoneAuthController.loginObscure.value =
                            !phoneAuthController.loginObscure.value,
                        node: phoneAuthController.passwordNode,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minimum 6 characters',
                      ),
                    ),


                    //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                    JiffyButton(
                      buttonText: 'SIGN IN',
                      onTap: phoneAuthController.loginUser,
                    ),


                    //DON'T HAVE AN ACCOUNT? - NAVIGATES TO SIGN UP PAGE
                    //FORGOT PASSWORD? - NAVIGATES TO RESET PASSWORD PAGE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Get.to(
                                () => const SignUpPage(),
                            transition: Transition.rightToLeft,
                            duration: .5.seconds,
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                 TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () => Get.to(
                                () => const RegisterScreen(),
                            transition: Transition.rightToLeft,
                            duration: .5.seconds,
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                 TextSpan(
                                  text: "Forgot Password?",
                                  style:  TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: ScreenSize.height(context) * 0.05),

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
