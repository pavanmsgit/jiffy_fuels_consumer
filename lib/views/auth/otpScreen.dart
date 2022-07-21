import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/phone_auth_controller.dart';
import 'package:jiffy_fuels_consumer/views/auth/register_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/app_buttons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/loading_widget.dart';


class OtpScreen extends StatelessWidget {
   OtpScreen({Key? key}) : super(key: key);

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //key: phoneAuthController.otpPageKey,
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: ScreenSize.width(context) * 0.1, horizontal: ScreenSize.height(context) * 0.05),
              child: Form(
                key: phoneAuthController.otpPageKey,
                child: Column(
                  children: [
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
                      height: ScreenSize.width(context) * 0.1,
                    ),

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

                    SizedBox(
                      height: ScreenSize.width(context) * 0.04,
                    ),

                    Text(
                      'Verification Code',
                      style: TextStyle(
                        fontSize: ScreenSize.width(context) * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.width(context) * 0.05,
                    ),
                    Text(
                      "Please Enter the OTP",
                      style: TextStyle(
                        fontSize: ScreenSize.width(context) * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textFieldOTP(context,first: true, last: false),
                              textFieldOTP(context,first: false, last: false),
                              textFieldOTP(context,first: false, last: false),
                              textFieldOTP(context,first: false, last: false),
                              textFieldOTP(context,first: false, last: false),
                              textFieldOTP(context,first: false, last: true),
                            ],
                          ),


                      ///PIN CODE TEXT FIELD FOR OTP
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: PinCodeTextField(
                          appContext: context,
                          controller: phoneAuthController.otp,
                          length: 6,
                          backgroundColor: AppColor.white,
                          cursorColor: AppColor.primaryColor,
                          obscureText: true,
                          //obscuringCharacter: '*',
                          obscuringWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(AppImages.appLogo),
                          ),
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            activeColor: Colors.deepOrange,
                            disabledColor: Colors.grey,
                            inactiveFillColor: Colors.white,
                            selectedColor: Colors.deepOrange,
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: ScreenSize.height(context) * 0.08,
                            fieldWidth: ScreenSize.width(context) * 0.1,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          onCompleted: (v) {
                          },
                          onChanged: (value) {
                          },
                        ),
                      ),



                        SizedBox(
                            height: ScreenSize.width(context) * 0.04,
                          ),



                          //SIGN IN BUTTON - GOES TO HOME OR SHOWS A TOAST
                          JiffyButton(
                            buttonText: 'CONTINUE',
                            onTap: () => phoneAuthController.verifyOtpAtOtpPage(context),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: ScreenSize.width(context) * 0.04,
                    ),

                    Text(
                      "Did not receive any code?",
                      style: TextStyle(
                        fontSize: ScreenSize.width(context) * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(
                      height:ScreenSize.width(context) * 0.025,
                    ),

                    TextButton(
                      //TODO - RE SEND OTP METHOD
                      onPressed: (){},
                      child: RichText(
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text:  "Resend New Code",
                              style:  TextStyle(
                                fontSize: ScreenSize.width(context) * 0.04,
                                color: AppColor.primaryColor,
                                fontWeight:  FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget textFieldOTP(BuildContext context, {required bool first, last}) {
    return SizedBox(
      height: ScreenSize.height(context) * 0.09,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
