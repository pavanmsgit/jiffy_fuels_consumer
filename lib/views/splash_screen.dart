import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/phone_auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    phoneAuthController.checkAuth();
    //phoneAuthController.getLocationPermission();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(),
              Expanded(
                child: Center(
                  child: Image(
                    height: ScreenSize.height(context) * 0.18,
                    image: const AssetImage(
                      AppImages.appLogo,
                    ),
                  ),
                ),
              ),
              const Text(
                'BY : CMR ENERGY PVT LTD',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
