import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';

selectOilCompany(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: StatefulBuilder(
          builder: (context, fun) {
            return SizedBox(
              height: ScreenSize.height(context),
              child: Column(
                children: [
                  Container(
                    color: AppColor.primaryColor,
                    height: ScreenSize.height(context) * 0.07,
                    child: Center(
                      child: Text(
                        'Select Oil Marketing Company',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder(
                      init: AuthController(),
                      builder: (_) => ListView.builder(
                        itemCount: authController.availaleOils.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) => Container(
                          height: ScreenSize.height(context) * 0.05,
                          color: authController.selectedOils
                                  .contains(authController.availaleOils[i])
                              ? Colors.grey.withOpacity(0.5)
                              : Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                authController.selectOilCompanies(index: i),
                            child: Text(
                              authController.availaleOils[i],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: AppColor.primaryColor,
                      height: ScreenSize.height(context) * 0.07,
                      child: Center(
                        child: Text(
                          'DONE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

yesNoDialog(context, {text, onTap}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        content: Builder(
          builder: (context) {
            return SizedBox(
              height: ScreenSize.height(context) * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ScreenSize.height(context) * 0.05),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            width: ScreenSize.width(context) * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          onTap: onTap,
                          child: Container(
                            height: ScreenSize.height(context) * 0.055,
                            // width: width(context) * 0.32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
