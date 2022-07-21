import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Image.asset(
          AppImages.appLogo,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      //title: Center(child: Text(title,style: const TextStyle(color: AppColor.primaryColor),)),
      elevation: 0.5,
      backgroundColor: AppColor.white,
    );
  }
}


appBarLogo(){
  return AppBar(
    title: Center(
      child: Image.asset(
        AppImages.appLogo,
        height: 50,
        fit: BoxFit.cover,
      ),
    ),
    //title: Center(child: Text(title,style: const TextStyle(color: AppColor.primaryColor),)),
    elevation: 0.5,
    backgroundColor: AppColor.white,
    leading: Container(),
  );
}