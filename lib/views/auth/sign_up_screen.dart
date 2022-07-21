import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/phone_auth_controller.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/views/auth/otpScreen.dart';
import 'package:jiffy_fuels_consumer/views/auth/register_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/app_buttons.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import 'package:jiffy_fuels_consumer/widgets/text_field.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/screen_size.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                key: phoneAuthController.signUpKey,
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



                    //SIGN UP PHONE NUMBER
                    TitleTextField(
                      title: 'Phone',
                      hint: 'Phone',
                      icon: const Icon(Icons.phone),
                      controller: phoneAuthController.mobileSignUp,
                      keyboardType: TextInputType.phone,
                      validator: (val) =>
                      val!.length == 10 ? null : 'Enter valid Phone Number',
                      onSubmit: (val) => phoneAuthController.mobileSignUpNode.requestFocus(),
                    ),

                    SizedBox(height: ScreenSize.height(context) * 0.015),


                    //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                    JiffyButton(
                      buttonText: 'SEND OTP',
                      // onTap: () => Get.to(
                      //       () => const OtpScreen(),
                      //   transition: Transition.rightToLeft,
                      //   duration: .5.seconds,
                      // ),

                      //onTap: authController.submitRegister,

                      onTap: phoneAuthController.sendOtpToDevice,

                      // onTap: (){
                      //   phoneAuthController.sendOtpAndVerify(context);
                      // },
                    ),

                    SizedBox(height: ScreenSize.height(context) * 0.005),

                    //ALREADY YOU HAVE AN ACCOUNT? - NAVIGATES TO SIGN IN PAGE
                    TextButton(
                      onPressed: () => Get.to(
                            () => const LoginScreen(),
                        transition: Transition.rightToLeft,
                        duration: .5.seconds,
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account?",
                              style:  TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
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
